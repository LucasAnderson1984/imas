# frozen_string_literal: true

module SimpleCrudController # :nodoc:
  extend ActiveSupport::Concern

  def index
    render_index
  end

  def show
    render_show(existing_resource)
  end

  protected

  def existing_resource
    @existing_resource ||= resource_class.find(params[:id])
  end

  def render_index
    render :index, locals: { resources: resources }
  end

  def resource_class
    @resource_class ||= resource_name.classify.constantize
  end

  def resource_name
    @resource_name ||= controller_name.singularize
  end
end
