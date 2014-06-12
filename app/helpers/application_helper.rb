module ApplicationHelper

  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end

  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to(name, "remove_fields(this)")
  end

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
