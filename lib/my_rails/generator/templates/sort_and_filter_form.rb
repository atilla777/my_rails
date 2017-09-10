class SortAndFilterForm
  DEFAULT_FIELD_NUMBER = 1

  attr_accessor :sort_field
  attr_reader :filter, :page, :sort_direction

  def initialize(relation, params = {}, default_sort_field)
    @relation = relation
    @default_sort_field = default_sort_field || columns[DEFAULT_FIELD_NUMBER]
    @filter = params.fetch(:filter, nil)
    @page = params.fetch(:page, nil)
    @sort_field = set_sort_field(params.fetch(:sort_field, nil))
    @sort_direction = set_sort_direction(params.fetch(:sort_direction, nil))
  end

  private
  def set_sort_field(params_sort_field)
    columns = @relation.column_names
    if columns.include?(params_sort_field)
      params_sort_field.to_sym
    else
      @default_sort_field
    end
  end

  def set_sort_direction(params_sort_direction)
    ['asc', 'desc'].include?(params_sort_direction) ? params_sort_direction.to_sym : :asc
  end
end
