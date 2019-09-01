# frozen_string_literal: true

module Admin
  class UsersController < ApplicationController # :nodoc:
    include SimpleCrudController

    def create
      user_entry = NewUserEntry.new(create_params)

      if user_entry.valid?
        user = User.new(create_params.merge(uuid: SecureRandom.uuid))
        user.save!

        redirect_to admin_user_path(user), notice: t('.success') and return
      end

      flash[:alert] = t('.failure')

      render_new(user_entry)
    end

    def edit
      render_edit(
        EditUserEntry.new(
          email: existing_resource.email,
          is_active: existing_resource.is_active,
          name: existing_resource.name
        )
      )
    end

    def new
      render_new(NewUserEntry.new)
    end

    def update
      user_entry = EditUserEntry.new(update_params)

      if user_entry.valid?
        user = existing_resource
        user.skip_reconfirmation!
        user.update!(update_params)

        redirect_to admin_user_path(user), notice: t('.success') and return
      end

      flash[:alert] = t('.failure')

      render_new(user_entry)
    end

    protected

    def create_params
      params
        .require(:user_entry)
        .permit(:email, :is_active, :name, :password)
    end

    def render_edit(user_entry)
      render :edit, locals: {
        user: existing_resource,
        user_entry: user_entry
      }
    end

    def render_new(user_entry)
      render :new, locals: {
        user_entry: user_entry
      }
    end

    def render_show(existing_user)
      render :show, locals: {
        resource: UserPresenter.new(existing_user, view_context)
      }
    end

    def resources
      @resources ||= resource_class.all.map do |user|
        UserPresenter.new(user, view_context)
      end
    end

    def update_params
      params
        .require(:user_entry)
        .permit(:email, :is_active, :name)
    end
  end
end
