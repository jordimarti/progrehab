class IngressosController < ApplicationController
  helper PlanificacionsHelper
  before_action :set_ingres, only: [:edit, :update]
  before_action :set_edifici
  respond_to :html, :js

  def edit
  end

  def update
    @ingres.update_attributes(ingres_params)
    @planificacio = Planificacio.find(@edifici.planificacio.id)
    @despeses = Despesa.where(edifici_id: @edifici.id).order(:data_any)
    @ingressos = Ingres.where(edifici_id: @edifici.id).order(:data_any)
    @tresoreries = Tresoreria.where(edifici_id: @edifici.id).order(:data_any)
    @primer_any = Date.today.year
    @ultim_any = @despeses.last.data_any
    helpers.actualitza_flux_tresoreria
  end


  private
    def set_ingres
      @ingres = Ingres.find(params[:id])
    end

    def set_edifici
      @edifici = Edifici.find(@ingres.edifici_id)
    end

    def ingres_params
      params.require(:ingres).permit(:edifici_id, :import, :data_mes, :data_any, :creat_usuari)
    end
end
