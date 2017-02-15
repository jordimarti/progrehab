class IdentificacionsController < ApplicationController
  include CheckUser
  before_action :set_identificacio, only: [:show, :edit, :update, :destroy]
  before_action :set_edifici
  
  def edit
    @subnavigation = true
    @submenu_actiu = 'identificacio'
    check_user_edifici(@edifici.id)
  end

  # POST /identificacions
  # POST /identificacions.json
  def create
    @identificacio = Identificacio.new(identificacio_params)

    respond_to do |format|
      if @identificacio.save
        format.html { redirect_to @identificacio, notice: 'Identificacio was successfully created.' }
        format.json { render :show, status: :created, location: @identificacio }
      else
        format.html { render :new }
        format.json { render json: @identificacio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /identificacions/1
  # PATCH/PUT /identificacions/1.json
  def update
    respond_to do |format|
      if @identificacio.update(identificacio_params)
        format.html { redirect_to edit_identificacio_path, notice: 'Identificacio was successfully updated.' }
        format.json { render :show, status: :ok, location: @identificacio }
      else
        format.html { render :edit }
        format.json { render json: @identificacio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /identificacions/1
  # DELETE /identificacions/1.json
  def destroy
    @identificacio.destroy
    respond_to do |format|
      format.html { redirect_to identificacions_url, notice: 'Identificacio was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_identificacio
      @identificacio = Identificacio.find(params[:id])
    end

    def set_edifici
      @edifici = Edifici.find(@identificacio.edifici_id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def identificacio_params
      params.require(:identificacio).permit(:edifici_id, :tipus_via, :nom_via, :numero_via, :bloc, :codi_postal, :poblacio, :provincia, :regim_juridic, :nom_titular, :nif_titular, :nom_representant, :nif_representant, :nom_tecnic, :nif_tecnic, :titulacio_tecnic, :colegi_tecnic, :num_colegiat_tecnic, :codi_ite, :data_emissio_ite, :nom_redactor_ite, :nif_redactor_ite, :titulacio_redactor_ite, :colegi_redactor_ite, :num_colegiat_redactor_ite, :num_expedient, :vigencia_limit_certificat, :qualificacio_certificat)
    end
end
