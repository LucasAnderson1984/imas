# frozen_string_literal: true

class SalesController < ApplicationController # :nodoc:
  include SimpleCrudController

  permitted_params :customer_id,
                   :item_id,
                   :sales_date,
                   :sales_quantity,
                   :unit_of_measure_id

  private

  def render_show(sale)
    render :show, locals: {
      sale: SalePresenter.new(sale, view_context)
    }
  end

  def resources
    @resources ||= Kaminari.paginate_array(sales).page(params[:page])
  end

  def sales
    @sales ||= resource_class.all.map do |sale|
      SalePresenter.new(sale, view_context)
    end
  end
end
