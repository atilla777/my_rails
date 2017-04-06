module SortAndFilter
  DEFAULT_FIELD_NUMBER = 1
  EXCLUDE_FROM_SEARCH = ['id', 'created_at', 'updated_at']
  private

  def filter_rows(relation, exlude_from_search = EXCLUDE_FROM_SEARCH)
    if params[:filter].present?
      fields = relation.attribute_names - exlude_from_search
      table = relation.table_name
      where_string = []
      fields.each do |field|
        where_string << %Q(LOWER(CAST("#{table}"."#{field}" AS text)) LIKE LOWER(:search))
      end
      where_string = where_string.join(' OR ')
      relation = relation.where(where_string, search: "%#{params.fetch(:filter, '')}%")
    else
      relation = relation.all
    end
    relation
  end

  # return current field name for sorting (based on params settings or on default value)
  # where params is:
  # relation - ActiveRelation or Model
  # default_field - name of field (as symbol) for sorting without params
  def order_rows(relation, default_field = false)
    relation.order(sort_field(relation, default_field) => sort_direction)
        .page params[:page]
  end

  def sort_field(relation, default_field = false)
    columns = relation.column_names
    field = default_field || columns[DEFAULT_FIELD_NUMBER]
    if columns.include?(params[:sort_field])
      params[:sort_field].to_sym
    else
      params[:sort_field] = field.to_sym
    end
    #columns.include?(params[:sort_field]) ? params[:sort_field].to_sym : field.to_sym
  end

  def sort_direction
    ['asc', 'desc'].include?(params[:sort_direction]) ? params[:sort_direction].to_sym : :asc
  end
end
