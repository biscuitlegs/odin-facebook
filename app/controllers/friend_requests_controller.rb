class FriendRequestsController < ApplicationController
    before_action :set_friend_request, only: :destroy
    before_action :new_friend_request, only: :create
    before_action :ensure_current_user_sending_friend_request, only: :create
    before_action :ensure_current_user_receiving_friend_request, only: :destroy

    def index
        @friend_requests = FriendRequest.where(receiving_user_id: current_user.id)
        @sending_users = @friend_requests.map { |request| User.find(request.sending_user_id) }
    end

    def create
        if @friend_request.save
            redirect_to posts_path, notice: "Friend request successfully sent."
        else
            redirect_to posts_path, alert: "Something went wrong sending your friend request."
        end
    end

    def destroy
        @friend_request.destroy
        redirect_to friend_requests_path, notice: "Successfully declined friend request."
    end

    private

    def friend_request_params
        params.require(:friend_request).permit(:receiving_user_id, :sending_user_id)
    end

    def set_friend_request
        @friend_request = FriendRequest.find(params[:id])
    end

    def new_friend_request
        @friend_request = FriendRequest.new(friend_request_params)
    end

    def ensure_current_user_sending_friend_request
        unless current_user_sending_friend_request?(@friend_request)
            redirect_to authenticated_root_path, alert: "You can only send friend requests from yourself!"
        end
    end

    def ensure_current_user_receiving_friend_request
        unless current_user_receiving_friend_request?(@friend_request)
            redirect_to authenticated_root_path, alert: "You can only reject friend requests addressed to yourself!"
        end
    end

    def current_user_sending_friend_request?(friend_request)
        friend_request.sending_user_id == current_user.id ? true : false
    end

    def current_user_receiving_friend_request?(friend_request)
        friend_request.receiving_user_id == current_user.id ? true : false
    end
end
