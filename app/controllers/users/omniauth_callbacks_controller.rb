class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    skip_before_action :verify_authenticity_token, only: :facebook
  
    def facebook
      @user = User.from_omniauth(request.env["omniauth.auth"])

      if updated_account_info?(@user)
        @user.first_name = request.env["omniauth.auth"].info.name.split(" ").first
        @user.last_name = request.env["omniauth.auth"].info.name.split(" ").last
        @user.email = request.env["omniauth.auth"].info.email
        @user.facebook_profile_picture = request.env["omniauth.auth"].info.picture
        
        @user.save
      end
  
      if @user.persisted?
        sign_in_and_redirect @user

        set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
      else
        session["devise.facebook_data"] = request.env["omniauth.auth"].except(:extra)

        redirect_to new_user_registration_url
      end
    end
  
    def failure
      redirect_to unauthenticated_root_path
    end

    def updated_account_info?(user)
        first_name = request.env["omniauth.auth"].info.name.split(" ").first
        last_name = request.env["omniauth.auth"].info.name.split(" ").last
        email = request.env["omniauth.auth"].info.email

        if @user.first_name != first_name || @user.last_name != last_name || @user.email != email
            return true
        else
            false
        end
    end
end