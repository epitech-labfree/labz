require 'oauth/controllers/provider_controller'
class OauthController < ApplicationController
  before_filter :print_all
  include OAuth::Controllers::ProviderController

  protected
  # Override this to match your authorization page form
  # It currently expects a checkbox called authorize
  # def user_authorizes_token?
  #   params[:authorize] == '1'
  # end

  # should authenticate and return a user if valid password.
  # This example should work with most Authlogic or Devise. Uncomment it
  def authenticate_user(username,password)
    user = User.find_by_email params[:username]
    if user && user.valid_password?(params[:password])
      user
    else
      nil
    end
  end

  alias :logged_in? :user_signed_in?
  alias :login_required :authenticate_user!

  def print_all
    request.env.each { |k, v| Rails.logger.warn "#{k} => #{v}" if k =~ /uth/}
    request.headers.each { |k, v| Rails.logger.warn "||| #{k} => #{v}" }
    true
  end

end
