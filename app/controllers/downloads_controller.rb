class DownloadsController < ApplicationController

  def show 
    respond_to do |format|
      format.pdf { send_edifici_pdf }

      if Rails.env.development?
        format.html { render_sample_html }
      end
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
