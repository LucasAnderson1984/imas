# frozen_string_literal: true

module MenuHelper # :nodoc:
  class CommonMenu < Menu # :nodoc:
    def initialize(user, context)
      super(context)

      @user = user
    end

    def items
      [
        item(t('menu.items'), context.items_path),
        item(t('menu.unit_of_measures'), context.unit_of_measures_path)
      ]
    end
  end
end
