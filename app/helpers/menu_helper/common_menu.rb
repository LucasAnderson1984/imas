# frozen_string_literal: true

module MenuHelper # :nodoc:
  class CommonMenu < Menu # :nodoc:
    def initialize(user, context)
      super(context)

      @user = user
    end

    def items
      menu_options.map do |menu_option|
        item(
          t("menu.#{menu_option}"),
          context.method("#{menu_option}_path").call
        )
      end
    end

    private

    def menu_options
      %w[bill_of_materials customers items sales unit_of_measures]
    end
  end
end
