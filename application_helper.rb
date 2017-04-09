module ApplicationHelper
  def link_to_sort(name, field, form, cont = controller.controller_name, act = controller.action_name)
    if form.sort_field == field
      direction_image = form.sort_direction == :asc ? 'glyphicon-triangle-top' : 'glyphicon-triangle-bottom'
      direction_image = %Q(<i class ='glyphicon #{direction_image}' aria-hidden='true'></i>)
    end
    new_sort_direction = form.sort_direction == :asc ? :desc : :asc
    link_to({controller: cont,
            action: act,
            filter: form.filter,
            sort_field: field,
            sort_direction: new_sort_direction},
            {remote: true,
            class: 'btn btn-link'}) do
      %Q(#{name}#{direction_image}).html_safe
    end
  end
end
