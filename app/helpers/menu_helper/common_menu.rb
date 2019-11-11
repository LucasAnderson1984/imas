# frozen_string_literal: true

module MenuHelper # :nodoc:
  class CommonMenu < Menu # :nodoc:
    def initialize(user, context)
      super(context)

      @user = user
    end

    def items
      menu_options.each_with_object([]) do |(key, value), results|
        results << item(t("menu.#{key}"), context.method(value).call)
      end
    end

    private

    def menu_options
      {
        bill_of_materials: 'bill_of_materials_path',
        customers: 'customers_path',
        items: 'items_path',
        unit_of_measures: 'unit_of_measures_path'
      }
    end
  end
end
