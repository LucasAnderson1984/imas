# frozen_string_literal: true

module MenuHelper # :nodoc:
  class CommonMenu < Menu # :nodoc:
    def initialize(user, context)
      super(context)

      @user = user
    end

    def items
      menu_options.each_with_object([]) do |value, results|
        results << item(
          t("menu.#{value}"),
          context.method("#{value}_path").call
        )
      end
    end

    private

    def menu_options
      %w[bill_of_materials customers items unit_of_measures]
    end
  end
end
