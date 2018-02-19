class Invoice < ApplicationRecord
  include PropertyFormatters
  include Workdays
  
  belongs_to :invoice_template
  belongs_to :user
  
  validates :workdays, :workdays_total, :unit_price_eur, 
            :date, :number, presence: true
  
  before_create :get_kurs, :calculate, :generate_template
  
  def set_fields
    set_template
    set_number
    set_unit_price_eur
    set_date
    self.workdays_total ||= workdays_for date
    self.workdays ||= workdays_total
    self
  end
  
private
  
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
  
  def set_template
    self.invoice_template = user.invoice_templates.first
  end
  
  def set_unit_price_eur
    self.unit_price_eur = invoice_template.unit_price_eur
  end
  
  def set_number
    self.number = (user.invoices.maximum(:number) || 0) + 1
  end
  
  def set_date
    self.date = DateTime.now.to_date
  end
  
  def set_workdays_total
    self.workdays_total = workdays_for date
  end
  
  # TODO: implement free days
  def set_workdays
    self.workdays = workdays_total
  end
end
