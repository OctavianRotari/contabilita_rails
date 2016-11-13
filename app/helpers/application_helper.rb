module ApplicationHelper
  def link_to_add_fields(name, form, association, class_name)
    new_object = form.object.send(association).klass.new
    id = new_object.object_id
    fields = form.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + '_fields', f: builder)
    end
    link_to(name, '#', class: class_name, data: {id:id, fields: fields.gsub('\n', '')})
  end

  def default_fields(form, association)
    new_object = form.object.send(association).klass.new
    id = 1
    form.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + '_fields', f: builder)
    end
  end

  def current_request?(*requests)
    return true if requests.include?({
      controller: controller.controller_name,
      action: controller.action_name
    })
    false
  end
end
