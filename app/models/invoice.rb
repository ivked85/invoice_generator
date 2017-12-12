class Invoice < ApplicationRecord
  belongs_to :invoice_template
  
  validates :workdays, :workdays_total, :unit_price_eur, 
            :kurs_eur, :number, presence: true
  
  before_validation :get_kurs
  before_save :calculate, :generate_template
  
  
  def calculate
    self.unit_price_rsd = (unit_price_eur * kurs_eur).to_f.round(2)
    self.price_eur = ((workdays * unit_price_eur) / workdays_total).to_f.round(2)
    self.price_rsd = (price_eur * kurs_eur).to_f.round(2)
  end
  
  def generate_template
    template = invoice_template.template
    template.gsub!(/{{.*?}}/) do |match|
      format_property match[2..-3]
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
  
  def format_property property
    if is_price? property
      return to_price(self.send(property))
    elsif is_date? property
      self.send(property).strftime('%d.%m.%Y')
    else
      self.send(property).to_s
    end
  end
  
  def is_price? property
    property.include? 'price'
  end
  
  def is_date? property
    self.send(property).methods.include? :strftime
  end
  
  def to_price number
    ActionController::Base.helpers.number_with_delimiter number, 
                                                          delimiter: '.', 
                                                          separator: ','
  end
end
