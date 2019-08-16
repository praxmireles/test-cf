# Mailer for Payment
class PaymentMailer < ApplicationMailer
  default from: 'team@mindswithpurpose.com'
  layout 'mailer'

  def paid_appointment(client_id, payment_id)
    @client = Client.find(client_id)
    @payment = Payment.find(payment_id)
    mail(to: @client.email, subject: 'Paid Appointment')
  end

  def sent_payout(expert_id, payment_id)
    @expert = Expert.find(expert_id)
    @payment = Payment.find(payment_id)
    mail(to: @expert.email, subject: 'Sent Payout')
  end

  def send_receipt(client_id, payment_id)
    @client = Client.find(client_id)
    @payment = Payment.find(payment_id)
    @expert = @payment.appointment.expert
    invoice = Invoice.find_by(user_id: client_id, payment_id: payment_id)
    generate_send_pdf invoice
    mail(to: @client.email, subject: 'Receipt Sent')
  end

  def pre_authorized_appointment(client_id, payment_id)
    @client = Client.find(client_id)
    @payment = Payment.find(payment_id)
    mail(to: @client.email, subject: 'MWP | Pre-approval Confirmation')
  end

  def generate_send_pdf(invoice)
    @invoice = invoice
    attachments['invoice.pdf'] = WickedPdf.new.pdf_from_string(
      render_to_string(pdf: 'invoice', template: 'pdf/client_invoice.html.haml')
    )
  end
end
