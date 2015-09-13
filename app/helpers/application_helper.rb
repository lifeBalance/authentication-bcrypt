module ApplicationHelper

  def bootstrap_class_for(flash_type)
    case flash_type
    when "success"
      "alert-success"   # Green
    when "error"
      "alert-danger"    # Red
    when "alert"
      "alert-warning"   # Yellow
    when "notice"
      "alert-info"      # Blue
    else
      flash_type.to_s
    end
  end

  def flash_messages(opts = {})
    flash.each do |key, value|
      concat(content_tag(:div, class: "alert #{bootstrap_class_for(key)} fade in") do
        concat value
        concat(content_tag(:button, 'x'.html_safe, class: "close", data: { dismiss: 'alert' }) do
          concat content_tag(:span, '&times;'.html_safe, 'aria-hidden' => true)
          concat content_tag(:span, 'Close', class: 'sr-only')
        end)
      end)
    end

    nil
  end
end
