class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :authenticate_user!, unless: :devise_controller?

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :first_name, :last_name, :profile_picture])
        devise_parameter_sanitizer.permit(:sign_in, keys: [:username, :email, :first_name, :last_name, :profile_picture])
        devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email, :first_name, :last_name, :profile_picture])
    end
end
