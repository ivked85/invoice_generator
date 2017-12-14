module PropertyFormatters
  ALLOWED_FORMATTERS = [:price, :date, :none]
  
  def format_property property, format_as=:none
    raise 'Uknown format' if ALLOWED_FORMATTERS.exclude? format_as
    self.send(format_as, [property])
  end
  
  # Formatters
  
  def price input
    ActionController::Base.helpers.number_with_delimiter input, 
                                                      delimiter: '.', 
                                                      separator: ','
  end
  
  def date input
    input.strftime('%d.%m.%Y')
  end
  
  def none input
    input.to_s
  end
end
