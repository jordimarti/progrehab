class DerramesController < ApplicationController
  before_action :set_derrama, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js

  def new
    @derrama = Derrama.new
  end

  def edit
  end

  def create
    @derrama = Derrama.create(derrama_params)
    @derrames = Derrama.where(:edifici_id => @derrama.edifici_id).order(:created_at)
    @fases = Fase.where(edifici_id: @derrama.edifici_id)
  end

  def update
    @derrama.update_attributes(derrama_params)
    @derrames = Derrama.where(:edifici_id => @derrama.edifici_id).order(:created_at)
    @fases = Fase.where(edifici_id: @derrama.edifici_id)
  end

  def destroy
    @derrames = Derrama.where(:edifici_id => @derrama.edifici_id).order(:created_at)
    @fases = Fase.where(edifici_id: @derrama.edifici_id)
    @derrama.destroy
  end

  private
    def set_derrama
      @derrama = Derrama.find(params[:id])
    end

    def set_edifici
      @edifici = Edifici.find(@derrama.edifici_id)
    end

    def derrama_params
      params.require(:derrama).permit(:edifici_id, :fase_id, :concepte, :import, :data_mes, :data_any)
    end
end
