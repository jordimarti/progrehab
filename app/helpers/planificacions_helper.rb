module PlanificacionsHelper

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
        planificacio = Planificacio.find(@edifici.planificacio.id)
        puts "Planificacio fons propis: #{planificacio.fons_propis}"
        tresoreria.import = planificacio.fons_propis
        tresoreria.save
      else
        calcula_tresoreria(tresoreria.data_mes, tresoreria.data_any)
      end
    end
  end


end
