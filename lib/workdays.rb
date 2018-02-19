module Workdays
  def workdays_for date
    invoice_date = Date.new(date.year, date.month, date.day)
    first_day_of_month = invoice_date.change(day: 1)
    last_day_of_month = invoice_date.change(day: -1)
    
    workdays = 0
    
    (first_day_of_month..last_day_of_month).each do |day|
      workdays += 1 unless is_holiday? day
    end
    
    workdays
  end
  
  def is_holiday? day
    return true if day.cwday.in? [6, 7]
    return Holiday.where(date: day).any?
  end
end
