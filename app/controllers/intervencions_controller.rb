class IntervencionsController < ApplicationController
  include CheckUser
  before_action :set_intervencio, only: [:show, :edit, :update, :destroy]
  before_action :set_edifici, only: [:index, :assignacions]
  respond_to :html, :js, :xml

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

  def assignacions
    @subnavigation = true
    @submenu_actiu = 'fases'
    @intervencions = Intervencio.where(edifici_id: params[:edifici_id])
    fase = Fase.find(params[:fase_id])
    @nom_fase = fase.nom
  end

  def assigna
    Intervencio.where(id: params[:intervencio_ids]).update_all({fase_id: params[:fase_id]})
    redirect_to fases_path(edifici_id: params[:edifici_id])
  end

  def exporta_xml
    @edifici = Edifici.find(params[:edifici_id])
    @intervencions = Intervencio.where(edifici_id: params[:edifici_id])
    respond_to do |format|
      format.xml do
        builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
          xml.edifici {
            xml.app "Programa manteniment"
            xml.edifici_id @edifici.id
            @intervencions.each do |intervencio|
              xml.intervencio {
                xml.descripcio intervencio.descripcio
                xml.sistema intervencio.sistema
                xml.import_obres intervencio.import_obres
                xml.import_honoraris intervencio.import_honoraris
                xml.import_taxes intervencio.import_taxes
                xml.import_altres intervencio.import_altres
              }
            end
          }
        end
        send_data builder.to_xml, filename: "#{@edifici.nom_edifici}.xml"
        puts "Ha arribat"
      end
    end
  end

  private
    def set_intervencio
      @intervencio = Intervencio.find(params[:id])
    end

    def set_edifici
      @edifici = Edifici.find(params[:edifici_id])
    end

    def intervencio_params
      params.require(:intervencio).permit(:edifici_id, :fase_id, :descripcio, :sistema, :import_obres, :import_honoraris, :import_taxes, :import_altres, :intervencio_ids, :data_inici_any, :data_inici_mes, :durada_mesos)
    end
end
