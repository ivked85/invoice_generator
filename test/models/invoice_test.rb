require 'test_helper'

class InvoiceTest < ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods
  
  def setup
    stub_kurs
  end
  
  test "should save valid invoice" do
    invoice = build(:invoice)
    assert invoice.save
  end
  
  test "should not save invoice without required fields" do
    %w[workdays workdays_total unit_price_eur date number].each do |field|
      invoice = build(:invoice)
      invoice.send("#{field}=", nil)
      refute invoice.save
    end
  end
  
  test "calculates correctly" do
    invoice = build(:invoice)
    invoice.save
    assert_equal 122.7899, invoice.kurs_eur
    assert_equal 122789.9, invoice.unit_price_rsd
    assert_equal 909.09, invoice.price_eur
    assert_equal 111627.07, invoice.price_rsd
  end
  
  test 'generates template correctly' do
    invoice = build(:invoice)
    invoice.save
    expected_template = '1,04.04.2016,111.627,07'
    assert_equal expected_template, invoice.template
  end

  # HELPERS
  def stub_kurs
    stub_request(:any, %r(api.kursna-lista.info)).
      to_return(body: File.new('test/fixtures/kurs_response.xml'), status: 200)
  end
end
