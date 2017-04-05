module ApplicationHelper
  def link_to_sort(name, field, cont = controller.controller_name, act = controller.action_name)
    direction = sort_direction
    if params[:sort_field].to_sym == field
      direction_image = direction == :asc ? 'glyphicon-triangle-bottom' : 'glyphicon-triangle-top'
      direction_image = %Q(<i class ='glyphicon #{direction_image}' aria-hidden='true'></i>)
    end
    new_sort_direction = direction == :asc ? :desc : :asc
    link_to({controller: cont,
            action: act,
            filter: params[:filter],
            sort_field: field,
            sort_direction: new_sort_direction},
            {remote: true,
            class: 'btn btn-link'}) do
      %Q(#{name}#{direction_image}).html_safe
    end
  end
end
