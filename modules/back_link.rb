module BackLink
  private
  def set_previous_action
      session[:return_to] ||= request.env['HTTP_REFERER']
  end

  def reset_previous_action
      session.delete(:return_to)
  end
end
