class SortRows
  def initialize(relation, form)
    @relation = relation
    @form = form
  end

  # return current field name for sorting (based on params settings or on default value)
  # where params is:
  # relation - ActiveRelation or Model
  # default_field - name of field (as symbol) for sorting without params
  def call
    @relation.order(@form.sort_field => @form.sort_direction)
  end
end

