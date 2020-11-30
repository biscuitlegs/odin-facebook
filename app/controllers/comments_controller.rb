class CommentsController < ApplicationController
    before_action :new_comment, only: :create
    before_action :set_comment, only: :destroy

    def create
        @comment.user_id = current_user.id

        if @comment.save
            redirect_to posts_path, notice: "Successfully created comment."
        else
            redirect_to posts_path, alert: "There was a problem creating your comment."
        end
    end

    def destroy
        fail
    end


    private

    def comment_params
        params.require(:comment).permit(:body, :post_id)
    end

    def new_comment
        @comment = Comment.new(comment_params)
    end
end
