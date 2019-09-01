# frozen_string_literal: true

module MenuHelper # :nodoc:
  class Menu # :nodoc:
    attr_reader :context

    alias h context
    delegate :concat, :content_tag, :link_to, :safe_join, :t, to: :context

    def initialize(context)
      @context = context
    end

    def dropdown_item(name, path, options = {})
      link_to(
        name,
        path,
        options.merge(class: 'btn btn-block d-inline-block text-left nav-link')
      )
    end

    def separator
      content_tag('div', class: 'dropdown-divider') {}
    end

    def item(name, path, options = {})
      content_tag('li', class: 'nav-item') do
        link_to(name, path, { class: 'nav-link' }.merge(options))
      end
    end
  end
end
