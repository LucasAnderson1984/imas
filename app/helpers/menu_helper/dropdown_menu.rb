# frozen_string_literal: true

module MenuHelper # :nodoc:
  class DropdownMenu # :nodoc:
    attr_reader :context

    delegate :concat, :content_tag, :link_to, :safe_join, to: :context

    def initialize(context, name, dropdown_classes = [], menu_classes = [])
      @context = context
      @name = name
      @dropdown_classes = dropdown_classes
      @menu_classes = menu_classes
    end

    def call
      content_tag('div', class: dropdown_classes.join(' ')) do
        concat(dropdown_link_widget)
        concat(content_tag('div', class: menu_classes.join(' ')) { yield })
      end
    end

    protected

    def dropdown_classes
      (@dropdown_classes << 'dropdown')
    end

    def dropdown_link_widget
      link_to(
        '#', class: 'dropdown-toggle nav-link', 'data-toggle' => 'dropdown'
      ) do
        concat @name
        concat safe_join([Nokogiri::HTML.fragment('&nbsp;')])
      end
    end

    def menu_classes
      %w[dropdown-menu].concat(@menu_classes).uniq
    end
  end
end
