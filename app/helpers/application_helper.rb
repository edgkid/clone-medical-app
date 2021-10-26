module ApplicationHelper
  def flash_class(level)
    case level
    when 'notice', 'alert' then 'green'
    when 'success' then 'blue'
    when 'error' then 'red'
    when 'warning' then 'yellow'
    else
      'green-text'
    end
  end
end
