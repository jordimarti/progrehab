class DocumentsController < ApplicationController
  include CheckUser
  before_action :set_edifici
  
  def index
  	@subnavigation = true
    @submenu_actiu = 'documents'
  end

  def progrehab_pdf_ca
    if params[:locale] == 'ca'
      url_edifici = 'http://progrehab.herokuapp.com/documents/vista_pdf_ca?edifici_id=#{@edifici.id.to_s}?locale=ca'
    elsif params[:locale] == 'es'
      
    end
    url_header = '#{Rails.root}/documents/vista_pdf_header?edifici_id=#{@edifici.id.to_s}?locale=ca'
    url_footer = '#{Rails.root}/documents/vista_pdf_footer?edifici_id=#{@edifici.id.to_s}?locale=ca'
    kit = PDFKit.new(url_edifici, :header_html => url_header, :footer_html => url_footer, :header_spacing => 5, :footer_spacing => 5, :margin_top => '1.0in', :margin_bottom => '1.3in')
    file = kit.to_file(Rails.root + 'tmp/' + 'demo.pdf')
    send_file file, filename: "#{@edifici.nom_edifici}.pdf", disposition: 'attachment'
  end

  def vista_pdf_ca
    #render :layout => 'pdf'
  end


  private
    def set_edifici
      @edifici = Edifici.find(params[:edifici_id])
    end
end
