module ApplicationHelper

  def custom_bootstrap_flash
    flash_messages = []
    option = "{'closeButton': true}"
    flash.each do |type, message|
      type = "success" if type == "notice" || type == "success"
      type = "error" if type == "alert"
      text = "toastr.#{type}('#{message}');"
      flash_messages << text if message
    end
    flash_messages.join("\n")
  end

  def full_title page_title
    base_title = I18n.t "helpers.base_title"
    if page_title.blank?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def flash_class level
    case level
    when :notice then "alert-info"
    when :error then "alert-danger"
    when :alert then "alert-warning"
    when :success then "alert-success"
    end
  end
end
