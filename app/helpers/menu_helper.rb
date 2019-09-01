# frozen_string_literal: true

module MenuHelper # :nodoc:
  def menu
    safe_join([left_nav, right_nav])
  end

  def left_nav
    content_tag('ul', class: 'navbar-nav mr-auto') do
      safe_join([left_menus.map(&:items).compact]) if user_signed_in?
    end
  end

  def right_nav
    content_tag('ul', class: 'nav navbar-nav navbar-right') do
      if user_signed_in?
        safe_join([right_menus.map(&:items).compact])
      else
        menu_item(t('menu.sign_in'), new_user_session_url)
      end
    end
  end

  def left_menus
    []
  end

  def right_menus
    [
      AdminMenu.new(current_user, self),
      UserMenu.new(current_user, self)
    ]
  end

  def menu_item(name, path, options = nil)
    content_tag('li') do
      link_to(name, path, options)
    end
  end
end
