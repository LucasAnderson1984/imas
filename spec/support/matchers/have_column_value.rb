# frozen_string_literal: true

RSpec::Matchers.define :have_column_value do |column_name, value|
  match do |table_row|
    table = table_row.first(:xpath, '../..')
    column_path = table
                  .find('thead th', text: /\A#{Regexp.escape(column_name)}\z/i)
                  .path
    column_index = (column_path.scan(/\[\d+\]$/).first || '').tr('[]', '').to_i

    expect(table_row.all('td')[column_index - 1])
      .to have_text(/\A#{Regexp.escape(value.to_s)}\z/i)
  end
end
