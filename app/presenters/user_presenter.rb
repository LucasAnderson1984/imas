# frozen_string_literal: true

class UserPresenter # :nodoc:
  attr_reader :user, :view_context

  delegate :t, to: :view_context
  delegate :email,
           :id,
           :is_active,
           :last_sign_in_at,
           :name,
           to: :user

  def initialize(user, view_context)
    @user = user
    @view_context = view_context
  end

  def status
    return t('presenters.user.active') if @user.active?

    t('presenters.user.inactive')
  end
end
