class DespesesController < ApplicationController
  before_action :set_despesa, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js

  def new
    @despesa = Despesa.new
  end

  def edit
  end

  def create
    @despesa = Despesa.create(despesa_params)
    @despeses = Despesa.where(:edifici_id => @despesa.edifici_id).order(:created_at)
    @fases = Fase.where(edifici_id: @despesa.edifici_id)
  end

  def update
    @despesa.update_attributes(despesa_params)
    @despeses = Despesa.where(:edifici_id => @despesa.edifici_id).order(:created_at)
    @fases = Fase.where(edifici_id: @despesa.edifici_id)
  end

  def destroy
    @despeses = Despesa.where(:edifici_id => @despesa.edifici_id).order(:created_at)
    @fases = Fase.where(edifici_id: @despesa.edifici_id)
    @despesa.destroy
  end

  private
    def set_despesa
      @despesa = Despesa.find(params[:id])
    end

    def set_edifici
      @edifici = Edifici.find(@despesa.edifici_id)
    end

    def despesa_params
      params.require(:despesa).permit(:edifici_id, :fase_id, :concepte, :import, :data_mes, :data_any)
    end
end
