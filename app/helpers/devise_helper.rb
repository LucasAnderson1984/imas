# frozen_string_literal: true

module DeviseHelper # :nodoc:
  def devise_error_messages!
    return '' if resource.errors.empty?

    html = <<-HTML
    <div class="devise-error-explanation">
      <h2>#{sentence}</h2>
      <ul>#{messages}</ul>
    </div>
    HTML

    html.html_safe
  end

  private

  def messages
    resource
      .errors
      .full_messages
      .map { |msg| content_tag(:li, msg) }
      .join
  end

  def sentence
    t('errors.messages.not_saved',
      count: resource.errors.count,
      resource: resource.class.model_name.human.downcase)
  end
end
