module ApplicationHelper
  def materialize_class_for flash_type
    { success: "teal lighten-3", error: "orange lighten-3", alert: "yellow lighten-3", notice: "blue lighten-4" }[flash_type.to_sym] || flash_type.to_s
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "notice card-panel #{materialize_class_for(msg_type)}") do
        concat message
      end)
    end
    nil
  end
end
