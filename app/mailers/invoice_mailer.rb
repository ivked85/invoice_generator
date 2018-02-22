class InvoiceMailer < ApplicationMailer
  default from: 'invoices@example.com'
  
  def email_invoice(user)
    mail(to: user.email, subject: 'invoice test')
  end
end
