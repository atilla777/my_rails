class ApplicationController < ActionController::Base
  include SortAndFilter
  include BackLink

  protect_from_forgery with: :exception
  helper_method :sort_direction, :sort_field
  before_action :set_previous_action, only: [:new, :edit, :destroy]
  before_action :reset_previous_action, only: [:index]

end
