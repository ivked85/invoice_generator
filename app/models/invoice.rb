class Invoice < ApplicationRecord
  include PropertyFormatters
  
  belongs_to :invoice_template
  
  validates :workdays, :workdays_total, :unit_price_eur, 
            :date, :number, presence: true
  
  before_save :get_kurs, :calculate, :generate_template
  
  
  def calculate
    self.unit_price_rsd = (unit_price_eur * kurs_eur).to_f.round(2)
    self.price_eur = ((workdays * unit_price_eur) / workdays_total).to_f.round(2)
    self.price_rsd = (price_eur * kurs_eur).to_f.round(2)
  end
  
  def generate_template
    template = invoice_template.template
    template.gsub!(/{{.*?}}/) do |match|
      format_property self.send(match[2..-3])
    end
    self.template = template
  end
  
  def get_kurs
    api_key = 'b430f7d843dedf4bb78f28f3d5507281'
    url = "https://api.kursna-lista.info/#{api_key}/kl_na_dan/#{date.strftime('%d.%m.%Y')}/xml"
    response = RestClient::Request.execute method: :get, url: url
    h = Hash.from_xml response
    self.kurs_eur = h["kursnalista"]["valuta"].find { |v| v["oznaka"] == "eur"  }["sre"].to_f
  end
  
  def method_missing(name, *args, &block)
    # adds dynamic format_{property} methods
    return format_property self.send(name[10..-1]) if name =~ %r{^format_} 
    super
  end
end
