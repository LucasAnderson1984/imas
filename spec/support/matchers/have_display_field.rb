# frozen_string_literal: true

RSpec::Matchers.define :have_display_field do |field_name, value|
  match do |block|
    label = block.first(
      :xpath,
      '//label',
      text: /\A#{Regexp.escape(field_name)}\z/i
    )

    value_container = label.first(:xpath, './/..')

    expect(value_container).to have_text(value)
  end
end
