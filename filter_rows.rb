class FilterRows
  EXCLUDE_FROM_SEARCH = ['id', 'created_at', 'updated_at']

  def initialize(options)
    @form = options[:form]
    @relation = options[:relation]
    @search_fields = options[:search_fields] || @relation.attribute_names
    exlude_from_search = options[:exlude_from_search] || EXCLUDE_FROM_SEARCH
    @search_fields = @search_fields - exlude_from_search
  end

  def call
    if @form.filter.present?
      table = @relation.table_name
      where_string = []
      @search_fields.each do |field|
        where_string << %Q(LOWER(CAST("#{table}"."#{field}" AS text)) LIKE LOWER(:search))
      end
      where_string = where_string.join(' OR ')
      @relation.where(where_string, search: "%#{@form.filter}%")
    else
      @relation.all
    end
  end
end
