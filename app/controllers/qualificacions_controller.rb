class QualificacionsController < ApplicationController
  include CheckUser
  before_action :set_qualificacio, only: [:show, :edit, :update, :destroy]
  before_action :set_edifici

  def edit
    @subnavigation = true
    @submenu_actiu = 'deficiencies'
    check_user_edifici(@edifici.id)
    if @qualificacio.xml_file.exists?
      @file_uploaded = true
    else
      @file_uploaded = false
    end
  end

  def update
    respond_to do |format|
      if @qualificacio.update(qualificacio_params)
        format.html { redirect_to edit_qualificacio_path, notice: 'Qualificacio was successfully updated.' }
        format.json { render :show, status: :ok, location: @qualificacio }
      else
        format.html { render :edit }
        format.json { render json: @qualificacio.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_qualificacio
      @qualificacio = Qualificacio.find(params[:id])
    end

    def set_edifici
      @edifici = Edifici.find(@qualificacio.edifici_id)
    end

    def qualificacio_params
      params.require(:qualificacio).permit(:edifici_id, :xml_file)
    end
end
