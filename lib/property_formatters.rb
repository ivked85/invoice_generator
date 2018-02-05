module PropertyFormatters
  ALLOWED_FORMATTERS = [:price, :date, :auto]
  
  def format_property property, format_as=:auto
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
  
  def auto_format input
    return price_format input if input.class == BigDecimal
    return date_format input if input.respond_to? :strftime
    
    input.to_s
  end
  
  def method_missing(name, *args, &block)
    # adds dynamic print_{property} methods
    return format_property self.send(name[6..-1]) if name =~ %r{^print_} 
    super
  end
end
