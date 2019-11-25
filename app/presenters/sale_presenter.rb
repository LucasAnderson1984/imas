# frozen_string_literal: true

class SalePresenter # :nodoc:
  attr_reader :sale, :view_context

  delegate :t, to: :view_context
  delegate :customer,
           :id,
           :item,
           :sales_date,
           :sales_quantity,
           :unit_of_measure,
           to: :sale

  def initialize(sale, view_context)
    @sale = sale
    @view_context = view_context
  end

  def sales_date_string
    @sale.sales_date.strftime('%m/%d/%Y')
  end

  def delimited_sales_quantity
    @view_context.number_with_delimiter(@sale.sales_quantity, delimiter: ',')
  end
end
