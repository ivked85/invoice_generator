class AddUserToInvoices < ActiveRecord::Migration[5.0]
  def change
    add_reference :invoice_templates, :user, foreign_key: true
    add_reference :invoices, :user, foreign_key: true
  end
end
