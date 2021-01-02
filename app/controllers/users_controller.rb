class UsersController < ApplicationController
    def index
        if params[:search]
            @users = User.where("id != ? AND (LOWER(CONCAT(first_name, ' ', last_name)) LIKE LOWER(?) OR LOWER(username) LIKE LOWER(?))", current_user.id, "%#{params[:search]}%", "%#{params[:search]}%")
        else
            @users = User.where("id != ?", current_user.id)
        end
    end

    def show
        @user = User.find_by(username: params[:username])
    end

    def update
        @user = User.find(params[:id])

        if @user.update(user_params)
            redirect_to profile_path(@user.username), notice: "Profile successfully updated."
        else
            flash.now[:alert] = "There was a problem updating your profile."
            render :show
        end
    end

    private

    def user_params
        params.require(:user).permit(:username, :first_name, :last_name, :email, :profile_picture)
    end
end

