class PlanificacionsController < ApplicationController
  include CheckUser
  before_action :set_planificacio, only: [:edit, :update, :fases, :calendari]
  before_action :set_edifici

  def edit
    @subnavigation = true
    @submenu_actiu = 'planificacio'
    check_user_edifici(@edifici.id)
  end

  def update
    respond_to do |format|
      if @planificacio.update(planificacio_params)
        format.html { redirect_to edit_planificacio_path, notice: 'Planificacio was successfully updated.' }
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
    check_user_edifici(@edifici.id)
    @fases = Fase.where(edifici_id: @edifici.id)
    @derrames = Derrama.where(edifici_id: @edifici.id)
  end

  def calendari
    @subnavigation = true
    @submenu_actiu = 'planificacio'
    check_user_edifici(@edifici.id)
    @derrames = Derrama.where(edifici_id: @edifici.id).order(:data_any)
    @primer_any = Date.today.year
    @ultim_any = @derrames.last.data_any
  end

  def crea_despeses
    despeses = Array.new{Array.new}
    derrama = Derrama.where(edifici_id: @edifici.id).order(:data_any)
    primer_any = Date.today.year
    ultim_any = derrama.last.data_any
    for i in primer_any..ultim_any
      for j in 0..11
        mes_derrama = derrama.where(edifici_id: @edifici.id, data_mes: j+1, data_any: i)
        if mes_derrama.exists?
          despeses[i][j] = mes_derrama.import
        else
          despeses[i][j] = 0
        end
      end
    end
  end

  def crea_ingressos
    derrama = Derrama.where(edifici_id: @edifici.id).order(:data_any)
    primer_any = Date.today.year
    ultim_any = derrama.last.data_any
    primer_mes = Date.today.month
    ultim_mes = derrama.last.data_mes
    for i in primer_any..ultim_any
      for j in 0..11
        if i >= primer_any && j >= primer_mes - 1
          if i <= ultim_any && j <= ultim_mes - 1
            ingres = Ingres.new
            ingres.edifici_id = @edifici.id
            ingres.data_mes = j+1
            ingres.data_any = i
            ingres.save
          end
        end
      end
    end
  end

  def actualitza_ingressos
    tresoreria = @planificacio.fons_propis

    mes_derrama = derrama.where(edifici_id: @edifici.id, data_mes: j+1, data_any: i)
        if mes_derrama.exists?
          despeses[i][j] = mes_derrama.last.import
        else
          despeses[i][j] = 0
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
