class DownloadsController < ApplicationController
  # Utilitzem helper_method per tenir-lo accessible des de la vista
  helper_method :comprova_qualificacions

  def show 
    respond_to do |format|
      format.pdf { send_edifici_pdf }

      if Rails.env.development?
        format.html { render_sample_html }
      end
    end
  end

  def comprova_qualificacions(sistema, qualificacio)
    deficiencies = Deficiencia.where(edifici_id: 2, sistema: sistema)
    if deficiencies.exists?
      deficiencies.each do |deficiencia|
        if deficiencia.qualificacio == qualificacio
          return 'X'
        else
          return nil
        end
      end
    else
      return nil
    end
  end


  private
 
  def edifici_pdf
    edifici = Edifici.find(params[:edifici_id])
    DocumentPdf.new(edifici)
  end
 
  def send_edifici_pdf
    send_file edifici_pdf.to_pdf,
      filename: edifici_pdf.filename,
      type: "application/pdf",
      disposition: "inline"
  end

  def render_sample_html
    edifici = Edifici.find(params[:edifici_id])
    render template: "edificis/pdf", layout: "pdf", locals: { edifici: edifici }
  end
end
