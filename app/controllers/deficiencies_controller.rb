class DeficienciesController < ApplicationController
  before_action :set_deficiencia, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js

  def new
    @deficiencia = Deficiencia.new
    @deficiencia.edifici_id = params[:edifici_id]
  end

  def edit
  end

  def create
    @deficiencia = Deficiencia.create(deficiencia_params)
    @deficiencies = Deficiencia.where(:edifici_id => @deficiencia.edifici_id).order(:created_at)
  end

  def update
    @deficiencia.update_attributes(deficiencia_params)
    @deficiencies = Deficiencia.where(:edifici_id => @deficiencia.edifici_id).order(:created_at)
  end

  def destroy
    @deficiencies = Deficiencia.where(:edifici_id => @deficiencia.edifici_id).order(:created_at)
    @deficiencia.destroy
  end

  private
    def set_deficiencia
      @deficiencia = Deficiencia.find(params[:id])
    end

    def deficiencia_params
      params.require(:deficiencia).permit(:edifici_id, :descripcio, :observacions, :sistema, :qualificacio)
    end
end
