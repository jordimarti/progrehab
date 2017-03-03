class IntervencionsController < ApplicationController
  include CheckUser
  before_action :set_intervencio, only: [:show, :edit, :update, :destroy]
  before_action :set_edifici, only: [:index, :assignacions]
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

  def assignacions
    @subnavigation = true
    @submenu_actiu = 'fases'
    @intervencions = Intervencio.all
    fase = Fase.find(params[:fase_id])
    @nom_fase = fase.nom
  end

  def assigna
    Intervencio.where(id: params[:intervencio_ids]).update_all({fase_id: params[:fase_id]})
    redirect_to fases_path(edifici_id: params[:edifici_id])
  end

  def exporta_xml
    @edifici = Edifici.find(params[:id])
    respond_to do |format|
      format.xml do
        builder = Nokogiri::XML::Builder.new do |xml|
          xml.edifici_id @edifici.id
          referencies = @edifici.referencies
          referencies.each do |ref|
            operacio = Operacio.find(ref.operacio_id)
            xml.operacio {
              xml.descripcio_ca operacio.descripcio_ca
            }
          end
        end
        send_data builder.to_xml, filename: "#{@edifici.nom_edifici}.xml"

        #File.open("out.xml", "w") do |f|     
        #  f.write(export_xml)   
        #end

        #file_to_save = File.new("tmp/export.xml", 'w+')
        #file_to_save.puts(export_xml)
        #file_to_save.close
        #file = export_xml.to_file(Rails.root + 'tmp/' + 'export.xml')
        #send_file out_file, filename: "#{@edifici.nom_edifici}.xml", disposition: 'attachment'
        #send_file file_to_save, filename: "prova.xml", disposition: 'attachment'
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
      params.require(:intervencio).permit(:edifici_id, :fase_id, :descripcio, :import_obres, :import_honoraris, :import_taxes, :import_altres, :intervencio_ids)
    end
end
