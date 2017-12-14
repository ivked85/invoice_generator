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
  
  def stub_kurs
    stub_request(:any, %r(api.kursna-lista.info)).
      to_return(body: File.new('test/fixtures/kurs_response.xml'), status: 200)
  end
end
