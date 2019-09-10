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

    if resource.save
      redirect_to resource_show_path, notice: t('.success') and return
    end

    flash[:alert] = t('.failure')

    render_new(resource)
  end

  def edit
    render_edit
  end

  def index
    render_index
  end

  def new
    render_new
  end

  def show
    render_show(existing_resource)
  end

  def update
    resource = resource_class.new(item_params)

    if resource.valid?
      resource = existing_resource
      resource.skip_reconfirmation!
      resource.update!(resource_params)

      redirect_to item_path(resource), notice: t('.success') and return
    end

    flash[:alert] = t('.failure')

    render_edit(resource)
  end

  protected

  def build_resource
    resource_class.new(resource_params)
  end

  def existing_resource
    @existing_resource ||= resource_class.find(params[:id])
  end

  def find_resource
    resource_class.find(params[:id])
  end

  def render_edit
    render :edit, locals: { resource: existing_resource }
  end

  def render_index
    render :index, locals: { resources: resources }
  end

  def render_new
    render :new, locals: { resource: resource }
  end

  def resource
    @resource ||= params[:id] ? find_resource : build_resource
  end

  def resource_class
    @resource_class ||= resource_name.classify.constantize
  end

  def resource_name
    @resource_name ||= controller_name.singularize
  end

  def resource_params
    return {} if params[resource_name.to_sym].nil?

    params.require(resource_name.to_sym).permit(self.class.permitted_params)
  end

  def resource_show_path
    [resource_class, 'path'].join('_').to_sym(resource)
  end

  def resources
    @resources ||= resource_class.all
  end
end
