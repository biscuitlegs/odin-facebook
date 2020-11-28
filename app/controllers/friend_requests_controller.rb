class FriendRequestsController < ApplicationController
    def index
        @friend_requests = FriendRequest.where(receiving_user_id: current_user.id)
        @sending_users = @friend_requests.map { |request| User.find(request.sending_user_id) }
    end

    def create
        @friend_request = FriendRequest.new(friend_request_params)

        if @friend_request.save
            redirect_to posts_path, notice: "Friend request successfully sent."
        else
            redirect_to posts_path, alert: "Something went wrong sending your friend request."
        end
    end

    def destroy
        @friend_request = FriendRequest.find(params[:id])

        @friend_request.destroy
        redirect_to friend_requests_path, notice: "Successfully declined friend request."
    end

    private

    def friend_request_params
        params.require(:friend_request).permit(:receiving_user_id, :sending_user_id)
    end
end
