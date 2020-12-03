class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :require_login, except: [:new, :create], if: :devise_controller?

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :first_name, :last_name, :profile_picture])
        devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :first_name, :last_name, :profile_picture])
        devise_parameter_sanitizer.permit(:account_update, keys: [:email, :first_name, :last_name, :profile_picture])
    end

    def require_login
        redirect_to unauthenticated_root_path unless user_signed_in?
    end
end
