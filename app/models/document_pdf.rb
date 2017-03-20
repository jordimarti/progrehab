require "render_anywhere"
 
class DocumentPdf

  include RenderAnywhere
 
  def initialize(edifici)
    @edifici = edifici
  end
 
  def to_pdf
    url_header = 'http://progrehab.herokuapp.com/edificis/pdf_header?locale=ca'
    kit = PDFKit.new(as_html, header_html: url_header, page_size: 'A4')
    kit.to_file("#{Rails.root}/public/programa.pdf")
  end
 
  def filename
    "Programa #{edifici.id}.pdf"
  end
 
  private
 
    attr_reader :edifici
 
    def as_html
      render template: "edificis/pdf", layout: "pdf", locals: { edifici: edifici }
    end


end