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
    @deficiencies = Deficiencia.where(:edifici_id => @edifici.id).order(:created_at)
  end

  def update
    @qualificacio.update(qualificacio_params)
    parse_file
    redirect_to edit_qualificacio_path
  end

  def parse_file
    tempfile = Paperclip.io_adapters.for(@qualificacio.xml_file)
    doc = Nokogiri::XML(tempfile)
    parse_xml(doc)
  end

  def parse_xml(doc)
    doc.root.elements.each do |node|
      parse_deficiencies(node)
    end
  end

  def parse_deficiencies(node)
    if node.node_name.eql? 'deficiencies'
      deficiencia = Deficiencia.new
      deficiencia.edifici_id = @qualificacio.edifici_id
      node.elements.each do |node|
        deficiencia.descripcio = node.text.to_s if node.name.eql? 'deficienciaDescripcio'
        deficiencia.observacions = node.text.to_s if node.name.eql? 'deficienciaObservacions'
        if node.name.eql? 'gravetat'
          node.elements.each do |node|
            deficiencia.qualificacio = node.text.to_s if node.name.eql? 'valor'
          end
        end
      end
      deficiencia.save
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
