module ApplicationHelper
  
  def hours_and_minutes(number)
    hours = (number / 60).to_i
    minutes = number.remainder(60)
    
    if hours > 0
      if minutes > 0 
        pluralize(hours, "hr") + ", " + pluralize(minutes, "min")
      else
        pluralize(hours, "hr")
      end
    else
      pluralize(minutes, "min")
    end
  end
  
  
end
