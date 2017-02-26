class FasesController < ApplicationController
  include CheckUser
  before_action :set_fase, only: [:edit, :update, :destroy]
  before_action :set_edifici, only: [:index, :assignacions]
  respond_to :html, :js

  def index
    check_user_edifici(params[:edifici_id])
    @subnavigation = true
    @submenu_actiu = 'fases'
    @fases = Fase.where(edifici_id: params[:edifici_id])
    @intervencions = Intervencio.where(edifici_id: params[:edifici_id])
  end

  def show
  end

  def new
    @fase = Fase.new
    @fase.edifici_id = params[:edifici_id]
    @intervencions = Intervencio.where(edifici_id: params[:edifici_id])
  end

  def edit
  end

  def create
    @fase = Fase.create(fase_params)
    @fases = Fase.where(edifici_id: @fase.edifici_id).order(:posicio)
    @intervencions = Intervencio.where(edifici_id: @fase.edifici_id)
    @edifici = Edifici.find(@fase.edifici_id)
  end

  def update
    @fase.update_attributes(fase_params)
    @fases = Fase.where(edifici_id: @fase.edifici_id).order(:posicio)
    @intervencions = Intervencio.where(edifici_id: @fase.edifici_id)
    @edifici = Edifici.find(@fase.edifici_id)
  end

  def destroy
    @fases = Fase.where(edifici_id: @fase.edifici_id).order(:posicio)
    @intervencions = Intervencio.where(edifici_id: @fase.edifici_id)
    @edifici = Edifici.find(@fase.edifici_id)
    @fase.destroy
  end

  def assignacions
    check_user_edifici(params[:edifici_id])
    @subnavigation = true
    @submenu_actiu = 'fases'
    @fases = Fase.where(edifici_id: params[:edifici_id])
    @intervencions = Intervencio.where(edifici_id: params[:edifici_id])
  end

  private
    def set_fase
      @fase = Fase.find(params[:id])
    end

    def set_edifici
      @edifici = Edifici.find(params[:edifici_id])
    end

    def fase_params
      params.require(:fase).permit(:edifici_id, :nom, :posicio, :observacions)
    end
end
