class ApplicationController < ActionController::Base
  # TODO: Ask Kyle About This
  # protect_from_forgery with: :exception

  before_action :initialize_session
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :cart

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:first_name, :last_name, :address, :province_id, :age, :email, :password) }

    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:first_name, :last_name, :address, :province_id, :age, :email, :password, :current_password) }
  end

  private

  def initialize_session
    session[:cart] ||= [] # Init shopping cart with nothing
  end

  def cart
    Movie.find(session[:cart])
  end
end
