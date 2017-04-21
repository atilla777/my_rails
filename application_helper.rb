module ApplicationHelper
  def link_to_sort(options)
    options[:controller] ||= controller.controller_name
    options[:action] ||= controller.action_name
    if options[:form].sort_field == options[:field_name]
      direction_image = options[:form].sort_direction == :asc ? 'glyphicon-triangle-top' : 'glyphicon-triangle-bottom'
      direction_image = %Q(<i class ='glyphicon #{direction_image}' aria-hidden='true'></i>)
    end
    new_sort_direction = options[:form].sort_direction == :asc ? :desc : :asc
    link_to({controller: options[:controller],
            action: options[:action],
            filter: options[:form].filter,
            sort_field: options[:field_name],
            sort_direction: new_sort_direction},
            {remote: true,
            class: 'btn btn-link'}) do
      %Q(#{options[:field_label]}#{direction_image}).html_safe
    end
  end
end
