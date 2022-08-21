# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  # before_filter :configure_permitted_parameters, if: :devise_controller?

  #   protected

  #       def configure_permitted_parameters
  #           devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name, :user_name, :email, :password) }
  #           devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:first_name, :last_name, :user_name, :email, :password, :current_password) }
  #       end

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name user_name])
  end
end
