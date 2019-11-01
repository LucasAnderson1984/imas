# frozen_string_literal: true

module SimpleCrudController # :nodoc:
  extend ActiveSupport::Concern

  class_methods do
    def permitted_params(*permitted)
      @_permitted_params = permitted unless permitted.empty?
      @_permitted_params
    end
  end

  def create
    resource = resource_class.new(
      resource_params.merge(uuid: SecureRandom.uuid)
    )

    redirect_to resource, notice: t('.success') and return if resource.save

    flash[:alert] = t('.failure')

    render_new(resource)
  end

  def edit
    render_edit(existing_resource)
  end

  def index
    render_index
  end

  def new
    render_new(new_resource({}))
  end

  def show
    render_show(existing_resource)
  end

  def update
    resource = existing_resource

    redirect_to resource, notice: t('.success') and return \
      if resource.update(resource_params)

    flash[:alert] = t('.failure')

    render_edit(resource)
  end

  protected

  def existing_resource
    @existing_resource ||= resource_class.find(params[:id])
  end

  def new_resource(params)
    resource_class.new(params)
  end

  def render_edit(resource)
    render :edit, locals: { resource_name.to_sym => resource }
  end

  def render_index
    render :index, locals: { controller_name.to_sym => resources }
  end

  def render_new(resource)
    render :new, locals: { resource_name.to_sym => resource }
  end

  def render_show(resource)
    render :show, locals: { resource_name.to_sym => resource }
  end

  def resource_class
    @resource_class ||= resource_name.classify.constantize
  end

  def resource_name
    @resource_name ||= controller_name.singularize
  end

  def resource_params
    params.require(resource_name.to_sym).permit(self.class.permitted_params)
  end

  def resources
    @resources ||= resource_class.all
  end
end
