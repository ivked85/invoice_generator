class AddUnitPriceToTemplates < ActiveRecord::Migration[5.0]
  def change
    add_column :invoice_templates, :unit_price_eur, :decimal
  end
end
