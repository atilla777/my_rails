class FilterRows
  EXCLUDE_FROM_SEARCH = ['id', 'created_at', 'updated_at']

  def initialize(relation, form, exlude_from_search = EXCLUDE_FROM_SEARCH)
    @form = form
    @relation = relation
    @exlude_from_search = exlude_from_search
  end

  def call
    if @form.filter.present?
      fields = @relation.attribute_names - @exlude_from_search
      table = @relation.table_name
      where_string = []
      fields.each do |field|
        where_string << %Q(LOWER(CAST("#{table}"."#{field}" AS text)) LIKE LOWER(:search))
      end
      where_string = where_string.join(' OR ')
      @relation.where(where_string, search: "%#{@form.filter}%")
    else
      @relation.all
    end
  end
end
