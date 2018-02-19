class AddPeriodToInvoices < ActiveRecord::Migration[5.0]
  def change
    add_column :invoices, :from_period, :date
    add_column :invoices, :to_period, :date
  end
end
