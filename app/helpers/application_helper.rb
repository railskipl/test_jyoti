module ApplicationHelper


def format_boolean(approved)
    if approved
      icon_tick
    else
      icon_cross
    end
  end

  def icon_tick(alt_text='Tick')
    build_image_tag("/assets/001_06.png", alt_text, 'Unsuspend Account')
  end

  def icon_cross(alt_text='Cross')
    build_image_tag("/assets/001_05.png", alt_text, 'Suspend Account')
  end

  def build_image_tag(image_file, alt_text, title)
    image_tag(image_file, :size =>"20x20", :alt => alt_text, :title => title)
  end


def resource_name
    :user
  end

  def resource
    @resource ||= User.create
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

end
