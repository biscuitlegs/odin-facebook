class UsersController < ApplicationController
    def index
        if params[:search]
            @users = User.where("LOWER(CONCAT(first_name, last_name)) LIKE LOWER(?)", "%#{params[:search]}%")
        else
            @users = User.where("id != ?", current_user.id)
        end
    end

    def show
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])

        if @user.update(user_params)
            redirect_to @user, notice: "Profile successfully updated."
        else
            render @user, notice: "There was a problem updating your profile."
        end
    end

    
    private

    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :profile_picture)
    end
end
