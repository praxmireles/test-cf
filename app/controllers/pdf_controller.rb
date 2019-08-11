# Manage to export Client & expert Invoices in PDF versions
class PdfController < ApplicationController
  def expert_invoice
    @invoice = Invoice.find_by_id(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        pdf = WickedPdf.new.pdf_from_string(render_to_string('pdf/expert_invoice.html.haml', layout: false))
        send_data(pdf, filename: 'invoice.pdf', type: 'application/pdf', disposition: 'attachment')
      end
    end
  end

  def client_invoice
    @invoice = Invoice.find_by_id(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        pdf = WickedPdf.new.pdf_from_string(render_to_string('pdf/client_invoice.html.haml', layout: false))
        send_data(pdf, filename: 'invoice.pdf', type: 'application/pdf', disposition: 'attachment')
      end
    end
  end
end
