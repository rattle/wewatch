module ApplicationHelper
  
  def hours_and_minutes(number)
    hours = (number / 3600).to_i
    minutes = (number/60).remainder(60)
    
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

  def show_flash
    [:notice,:error].each do |type|
      content_tag(:div, "<p>#{flash[type]}</p>".html_safe, :class => type) if flash[type]
    end
  end
  
  
end
