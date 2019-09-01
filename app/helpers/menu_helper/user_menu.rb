# frozen_string_literal: true

module MenuHelper # :nodoc:
  class UserMenu < Menu # :nodoc:
    def initialize(user, context)
      super(context)

      @user = user
    end

    def items
      [
        DropdownMenu.new(
          @context,
          safe_join([@user.name, gravatar]),
          %w[user-dropdown],
          %w[dropdown-menu-right]
        ).call do
          concat safe_join(user_items)
        end
      ]
    end

    protected

    def gravatar
      @context.gravatar_image_tag(
        @user.email,
        alt: @user.name,
        class: 'rounded-circle user-dropdown__gravatar'
      )
    end

    def sign_out_item
      dropdown_item(t('menu.sign_out'),
                    context.destroy_user_session_url,
                    method: :delete)
    end

    def user_items
      [sign_out_item]
    end
  end
end
