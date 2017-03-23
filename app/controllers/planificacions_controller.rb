class PlanificacionsController < ApplicationController
  include CheckUser
  before_action :set_planificacio, only: [:edit, :update, :fases, :calendari, :crea_ingressos, :actualitza_ingressos, :crea_valors_inicials]
  before_action :set_edifici

  def edit
    @subnavigation = true
    @submenu_actiu = 'planificacio'
    @planificacio_menu_actiu = 'info_previa'
    check_user_edifici(@edifici.id)
  end

  def update
    respond_to do |format|
      if @planificacio.update(planificacio_params)
        format.html { redirect_to edit_planificacio_path, notice: t('.guardat_ok') }
        format.json { render :show, status: :ok, location: @planificacio }
      else
        format.html { render :edit }
        format.json { render json: @planificacio.errors, status: :unprocessable_entity }
      end
    end
  end

  def fases
    @subnavigation = true
    @submenu_actiu = 'planificacio'
    @planificacio_menu_actiu = 'planificacio_fases'
    check_user_edifici(@edifici.id)
    @fases = Fase.where(edifici_id: @edifici.id)
    @despeses = Despesa.where(edifici_id: @edifici.id)
  end

  def calendari
    @subnavigation = true
    @submenu_actiu = 'planificacio'
    @planificacio_menu_actiu = 'calendari'
    check_user_edifici(@edifici.id)
    @despeses = Despesa.where(edifici_id: @edifici.id).order(:data_any)
    @ingressos = Ingres.where(edifici_id: @edifici.id).order(:data_any)
    @tresoreries = Tresoreria.where(edifici_id: @edifici.id).order(:data_any)
    @primer_any = Date.today.year
    @ultim_any = @despeses.last.data_any
    # Cada vegada que accedim al calendari s'actualitzen els valors de tresoreria, perquè poden haver canviat les despeses
    actualitza_flux_tresoreria
  end

  def crea_valors_inicials
    Ingres.where(edifici_id: @edifici.id).destroy_all
    Tresoreria.where(edifici_id: @edifici.id).destroy_all
    crea_ingressos
    actualitza_ingressos
    redirect_to calendari_path(id: @edifici.planificacio.id, edifici_id: @edifici.id)
  end

  # Això fa algo???
=begin
  def crea_despeses
    despeses = Array.new{Array.new}
    despesa = Despesa.where(edifici_id: @edifici.id).order(:data_any)
    primer_any = Date.today.year
    ultim_any = despesa.last.data_any
    for i in primer_any..ultim_any
      for j in 1..12
        mes_despesa = despesa.where(edifici_id: @edifici.id, data_mes: j, data_any: i)
        if mes_despesa.exists?
          despeses[i][j] = mes_despesa.import
        else
          despeses[i][j] = 0
        end
      end
    end
  end
=end

  def crea_ingressos
    despeses = Despesa.where(edifici_id: @edifici.id).order(:data_any)
    primer_any = Date.today.year
    ultim_any = despeses.last.data_any
    primer_mes = Date.today.month
    ultim_mes = despeses.last.data_mes
    for i in primer_any..ultim_any
      for j in 1..12
        if i == primer_any && j <= primer_mes
          # Aquí es crea el primer registre de tresoreria. Els mesos següents hi ha tresoreria i ingressos
          if i == primer_any && j == primer_mes
            tresoreria = Tresoreria.new
            tresoreria.edifici_id = @edifici.id
            tresoreria.data_mes = j
            tresoreria.data_any = i
            tresoreria.import = @planificacio.fons_propis
            tresoreria.save
          end
        else
          if i == ultim_any && j > ultim_mes
          else
            ingres = Ingres.new
            ingres.edifici_id = @edifici.id
            ingres.data_mes = j
            ingres.data_any = i
            ingres.import = 0
            ingres.save
            tresoreria = Tresoreria.new
            tresoreria.edifici_id = @edifici.id
            tresoreria.data_mes = j
            tresoreria.data_any = i
            tresoreria.import = 0
            tresoreria.save
          end
        end
      end
    end
  end

  def actualitza_ingressos
    tresoreries = Tresoreria.where(edifici_id: @edifici.id).order(:data_any, :data_mes)
    despeses = Despesa.where(edifici_id: @edifici.id).order(:data_any, :data_mes)
    ingressos = Ingres.where(edifici_id: @edifici.id).order(:data_any, :data_mes)
    data_inici_any = Date.today.year
    data_inici_mes = Date.today.month
    import_ultima_tresoreria = @planificacio.fons_propis
    despeses.each do |despesa|
      mesos_repartir = 0
      tresoreria = tresoreries.where(data_any: data_inici_any, data_mes: data_inici_mes).last
      import_repartir = import_ultima_tresoreria - despesa.import
      # Si no hi ha prous diners a tresoreria cal fer ingressos
      if import_repartir < 0
        # Calculem els mesos a repartir
        ingressos.each do |ingres|
          if ingres.data_any >= data_inici_any 
            if ingres.data_any == data_inici_any && ingres.data_mes < data_inici_mes
            else
              if ingres.data_any <= despesa.data_any
                if ingres.data_any == despesa.data_any && ingres.data_mes > despesa.data_mes
                else
                  mesos_repartir += 1
                end
              end
            end
          end
        end
        puts "Mesos a repartir: #{mesos_repartir}"
        puts "Import a repartir: #{import_repartir}"
        import_mensual = -(import_repartir/mesos_repartir)
        ingressos.each do |ingres|
          # Comprovem que estem en el rang temporal que correspon
          if ingres.data_any >= data_inici_any 
            if ingres.data_any == data_inici_any && ingres.data_mes < data_inici_mes
            else
              if ingres.data_any <= despesa.data_any
                if ingres.data_any == despesa.data_any && ingres.data_mes > despesa.data_mes
                else
                  ingres.import = import_mensual
                  puts "Ingres import mensual: #{ingres.import}"
                  ingres.save
                  calcula_tresoreria(ingres.data_mes, ingres.data_any)
                end
              end
            end
          end
        end
      end
      data_inici_mes = despesa.data_mes + 1
      data_inici_any = despesa.data_any
      # Comprovem si la data canvia d'any, el mes és 13, això vol dir que el mes ha de ser 1 i l'any +1
      if data_inici_mes > 12
        data_inici_any = despesa.data_any + 1
        data_inici_mes = 1
      end
      puts "Any #{data_inici_any}, mes #{data_inici_mes}"
      ultima_tresoreria = Tresoreria.where(edifici_id: @edifici.id, data_any: data_inici_any, data_mes: data_inici_mes).last
      # En el cas que sigui l'última despesa no hi haurà tresoreria creada per al mes següent
      if ultima_tresoreria != nil
        puts "Import ultima tresoreria: #{ultima_tresoreria.import}"
        import_ultima_tresoreria = ultima_tresoreria.import
      end
      puts "Despesa finalitzada"
    end
  end

  def calcula_tresoreria(mes, any)
    if mes == 1
      tresoreria_anterior = Tresoreria.where(edifici_id: @edifici.id, data_any: any - 1, data_mes: 12).last
    else
      tresoreria_anterior = Tresoreria.where(edifici_id: @edifici.id, data_any: any, data_mes: mes - 1).last
    end
    puts "Tresoreria mes anterior: #{tresoreria_anterior.import}, data_any: #{tresoreria_anterior.data_any}, data_mes: #{tresoreria_anterior.data_mes}"
    
    # Comprovem si en el mes i any que estem hi ha despesa
    despesa = Despesa.where(edifici_id: @edifici.id, data_mes: mes, data_any: any).last
    ingres = Ingres.where(edifici_id: @edifici.id, data_mes: mes, data_any: any).last
    if despesa != nil
      import_tresoreria = tresoreria_anterior.import + ingres.import - despesa.import
    else
      import_tresoreria = tresoreria_anterior.import + ingres.import
    end
    tresoreria = Tresoreria.where(edifici_id: @edifici.id, data_mes: mes, data_any: any).last
    tresoreria.import = import_tresoreria
    puts "Import tresoreria: #{tresoreria.import}"
    tresoreria.save
  end

  def actualitza_flux_tresoreria
    # Com que prèviament ja s'han creat els registres de tresoreria inicials, actualitzem els registres de tresoreria que ja existeixen
    tresoreries = Tresoreria.where(edifici_id: @edifici.id).order(:data_any, :data_mes)
    primera_tresoreria = tresoreries.first
    puts "Primera tresoreria #{primera_tresoreria.id}, import: #{primera_tresoreria.import}"
    tresoreries.each do |tresoreria|
      # Comprovem que no es tracti de la primera tresoreria, perquè així no mira el mes anterior sinó que actualitza segons fons propis
      if tresoreria.id == primera_tresoreria.id
        planificacio = Planificacio.find(params[:id])
        puts "Planificacio fons propis: #{planificacio.fons_propis}"
        tresoreria.import = planificacio.fons_propis
        tresoreria.save
      else
        calcula_tresoreria(tresoreria.data_mes, tresoreria.data_any)
      end
    end
  end

  private
    def set_planificacio
      @planificacio = Planificacio.find(params[:id])
    end

    def set_edifici
      @edifici = Edifici.find(@planificacio.edifici_id)
    end

    def planificacio_params
      params.require(:planificacio).permit(:edifici_id, :fons_propis, :subvencions_solicitades, :subvencions_atorgades, :import_financar, :forma_financar)
    end
end
