module PropertyFormatters
  ALLOWED_FORMATTERS = [:price, :date, :none]
  
  def format_property property, format_as=:none
    raise 'Uknown format' if ALLOWED_FORMATTERS.exclude? format_as
    self.send("#{format_as.to_s}_format", property)
  end
  
  # Formatters
  
  def price_format input
    ActionController::Base.helpers.number_with_delimiter input, 
                                                      delimiter: '.', 
                                                      separator: ','
  end
  
  def date_format input
    input.strftime('%d.%m.%Y')
  end
  
  def none_format input
    return price_format input if input.class == BigDecimal
    return date_format input if input.respond_to? :strftime
    
    input.to_s
  end
end
