class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  # 当前登录用户
  def current_user
  	@current_user ||= User.find(1)
  end

  def forbidden
  	render :status => :forbidden, :text => "您没有权限访问此页面"
  end

end
