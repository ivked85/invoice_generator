 FactoryBot.define do
   factory :invoice_template do
           name 'test template'
           template '{{number}},{{date}},{{price_rsd}}'
   end
 end
 