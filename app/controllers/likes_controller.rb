class LikesController < ApplicationController
    before_action :new_like, only: :create
    before_action :set_like, only: :destroy
    before_action :ensure_current_user_owns_like

    def create
        if @like.save
            redirect_to posts_path, notice: "Liked successfully."
        else
            redirect_to posts_path, alert: "Something went wrong liking this post!"
        end
    end

    def destroy
        @like.destroy
        redirect_to posts_path, notice: "Like successfully removed."
    end


    private

    def like_params
        params.require(:like).permit(:user_id, :post_id)
    end

    def ensure_current_user_owns_like
        unless current_user_owns_like?(@like)
            redirect_to authenticated_root_path, alert: "You can only manage likes that you have given!"
        end
    end

    def current_user_owns_like?(like)
        like.user_id == current_user.id ? true : false
    end

    def set_like
        @like = Like.find(params[:id])
    end

    def new_like
        @like = Like.new(like_params)
    end
end
