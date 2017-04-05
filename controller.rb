<% if namespaced? -%>
require_dependency "<%= namespaced_path %>/application_controller"

<% end -%>
<% module_namespacing do -%>
class <%= controller_class_name %>Controller < ApplicationController

  # GET <%= route_url %>
  def index
    <%= plural_table_name %> = filter_rows(<%= singular_table_name.classify %>)
    @<%= plural_table_name %> = order_rows(<%= plural_table_name %>)
    respond_to do |format|
      format.html
      format.js {render '<%= plural_table_name %>'}
    end
  end

  # GET <%= route_url %>/1
  def show
    @<%= singular_table_name %> = set_<%= singular_table_name %>
  end

  # GET <%= route_url %>/new
  def new
    @<%= singular_table_name %> = <%= orm_class.build(class_name) %>
  end

  # GET <%= route_url %>/1/edit
  def edit
    @<%= singular_table_name %> = set_<%= singular_table_name %>
  end

  # POST <%= route_url %>
  def create
    @<%= singular_table_name %> = <%= orm_class.build(class_name, "#{singular_table_name}_params") %>

    if @<%= orm_instance.save %>
      redirect_to <%= plural_table_name %>_path, notice: t('flashes.create', model: <%= singular_table_name.classify %>.model_name.human)
    else
      render :new
    end
  end

  # PATCH/PUT <%= route_url %>/1
  def update
    @<%= singular_table_name %> = set_<%= singular_table_name %>
    if @<%= orm_instance.update("#{singular_table_name}_params") %>
      redirect_to @<%= singular_table_name %>, notice: t('flashes.update', model: <%= singular_table_name.classify %>.model_name.human)
    else
      render :edit
    end
  end

  # DELETE <%= route_url %>/1
  def destroy
    @<%= singular_table_name %> = set_<%= singular_table_name %>
    @<%= orm_instance.destroy %>
    redirect_to <%= index_helper %>_url, notice: t('flashes.destroy', model: <%= singular_table_name.classify %>.model_name.human)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_<%= singular_table_name %>
      @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
    end

    # Only allow a trusted parameter "white list" through.
    def <%= "#{singular_table_name}_params" %>
      <%- if attributes_names.empty? -%>
      params.fetch(:<%= singular_table_name %>, {})
      <%- else -%>
      params.require(:<%= singular_table_name %>).permit(<%= attributes_names.map { |name| ":#{name}" }.join(', ') %>)
      <%- end -%>
    end
end
<% end -%>
