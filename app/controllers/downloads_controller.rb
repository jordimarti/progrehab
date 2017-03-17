class DownloadsController < ApplicationController
 
  def show
    respond_to do |format|
      format.pdf { send_edifici_pdf }
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
end
