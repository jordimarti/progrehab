class IntervencionsController < ApplicationController
  include CheckUser
  before_action :set_intervencio, only: [:show, :edit, :update, :destroy]
  before_action :set_edifici, only: [:index]
  respond_to :html, :js

  def index
    @subnavigation = true
    @submenu_actiu = 'intervencions'
    @intervencions = Intervencio.where(edifici_id: params[:edifici_id])
    check_user_edifici(params[:edifici_id])
  end

  def new
    @intervencio = Intervencio.new
    @intervencio.edifici_id = params[:edifici_id]
  end

  def edit
  end

  def create
    @intervencio = Intervencio.create(intervencio_params)
    @intervencions = Intervencio.where(:edifici_id => @intervencio.edifici_id).order(:created_at)
  end

  def update
    @intervencio.update_attributes(intervencio_params)
    @intervencions = Intervencio.where(:edifici_id => @intervencio.edifici_id).order(:created_at)
  end

  def destroy
    @intervencions = Intervencio.where(:edifici_id => @intervencio.edifici_id).order(:created_at)
    @intervencio.destroy
  end

  private
    def set_intervencio
      @intervencio = Intervencio.find(params[:id])
    end

    def set_edifici
      @edifici = Edifici.find(params[:edifici_id])
    end

    def intervencio_params
      params.require(:intervencio).permit(:edifici_id, :fase_id, :descripcio, :import_obres, :import_honoraris, :import_taxes, :import_altres)
    end
end
