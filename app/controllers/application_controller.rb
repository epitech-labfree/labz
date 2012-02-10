class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user=(user)
    sign_in user
  end

  def logged_in?
    current_user
  end
end
