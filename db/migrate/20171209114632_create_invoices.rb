class CreateInvoices < ActiveRecord::Migration[5.0]
  def change
    create_table :invoices do |t|
      t.decimal :kurs_eur
      t.decimal :base_price
      t.string :unit_price_eur
      t.string :unit_price_rsd
      t.string :price_eur
      t.string :price_rsd
      t.integer :workdays
      t.integer :workdays_total
      t.integer :number
      t.string :date
      t.text    :template
      
      t.references :invoice_template, index: true
      
      t.timestamps
    end
  end
end
