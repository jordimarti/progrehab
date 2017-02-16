class IdentificacionsController < ApplicationController
  include CheckUser
  before_action :set_identificacio, only: [:show, :edit, :update, :destroy]
  before_action :set_edifici
  
  def edit
    @subnavigation = true
    @submenu_actiu = 'identificacio'
    check_user_edifici(@edifici.id)
  end

  def update
    respond_to do |format|
      if @identificacio.update(identificacio_params)
        format.html { redirect_to edit_identificacio_path, notice: t('.guardat_ok') }
        format.json { render :show, status: :ok, location: @identificacio }
      else
        format.html { render :edit }
        format.json { render json: @identificacio.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_identificacio
      @identificacio = Identificacio.find(params[:id])
    end

    def set_edifici
      @edifici = Edifici.find(@identificacio.edifici_id)
    end

    def identificacio_params
      params.require(:identificacio).permit(:edifici_id, :tipus_via, :nom_via, :numero_via, :bloc, :codi_postal, :poblacio, :provincia, :regim_juridic, :nom_titular, :nif_titular, :nom_representant, :nif_representant, :nom_tecnic, :nif_tecnic, :titulacio_tecnic, :colegi_tecnic, :num_colegiat_tecnic, :codi_ite, :data_emissio_ite, :nom_redactor_ite, :nif_redactor_ite, :titulacio_redactor_ite, :colegi_redactor_ite, :num_colegiat_redactor_ite, :num_expedient, :vigencia_limit_certificat, :qualificacio_certificat, :data_primera_verificacio, :data_recepcio_informe, :termini_aprovacio_programa)
    end
end
