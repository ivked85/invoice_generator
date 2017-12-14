 FactoryBot.define do
   factory :invoice do
           number 1
           workdays 20
           workdays_total 22
           unit_price_eur 1000
           date Date.new(2016, 4, 4)
           association :invoice_template
   end
 end
 