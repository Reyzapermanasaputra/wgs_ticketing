module DeviseHelper
	def devise_error_messages!
    begin
  		return "" if resource.errors.empty?
  		messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
      sentence = I18n.t("errors.messages.not_saved",
                        count: resource.errors.count,
                        resource: resource.class.model_name.human.downcase)

      html = <<-HTML
        #{messages}
      HTML

      html.html_safe
    rescue
      return ""
    end
	end
end