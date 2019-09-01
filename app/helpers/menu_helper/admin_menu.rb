# frozen_string_literal: true

module MenuHelper # :nodoc:
  class AdminMenu < Menu # :nodoc:
    def initialize(user, context)
      super(context)

      @user = user
    end

    def items
      dropdown_items = [
        dropdown_item(t('menu.admin.users'), h.admin_users_url)
      ]

      [
        DropdownMenu.new(@context, 'Admin', %w[admin-dropdown]).call do
          concat safe_join(dropdown_items)
        end
      ]
    end
  end
end
