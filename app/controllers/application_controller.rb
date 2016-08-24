class ApplicationController < Kinetic::ApplicationController
  rescue_from Kinetic::Exceptions::GravityException, with: :handle_gravity_exception
  rescue_from Kinetic::Exceptions::NotAuthorized, with: :clear_session_and_reauth!

  add_flash_types :error, :fullscreen_notice, :fullscreen_error, :async_notice, :async_error

  before_action :find_current_user
  before_action :require_current_user
  before_action :require_admin

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
