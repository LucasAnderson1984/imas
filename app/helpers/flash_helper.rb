# frozen_string_literal: true

module FlashHelper # :nodoc:
  ALERT_TYPES_MAP = {
    notice: :success,
    alert: :danger,
    error: :danger,
    info: :notice,
    warning: :alert
  }.freeze

  def flash_messages
    flashes = flash.each_with_object([]) do |(type, message), messages|
      next if message.blank? || !message.respond_to?(:to_str)

      messages << flash_container(type, message)
    end

    safe_join(flashes, "\n").presence
  end

  def flash_container(type, message)
    css_type = ALERT_TYPES_MAP.fetch(type.to_sym, type)

    content_tag :div, class: 'root flash' do
      concat(
        content_tag(:div, class: "alert alert-#{css_type} alert-dismissible") do
          concat(close_alert_element)
          concat(message)
        end
      )
    end
  end

  def close_alert_element
    content_tag(:button,
                class: 'close',
                'data-dismiss' => 'alert',
                'aria-label' => 'close') do
      content_tag(:span, 'aria-hidden' => 'true') do
        safe_join([Nokogiri::HTML.fragment('&times;')])
      end
    end
  end
end
