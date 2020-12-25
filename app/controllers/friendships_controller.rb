class FriendshipsController < ApplicationController
    before_action :new_friendship, only: :create
    before_action :set_friendship, only: :destroy
    before_action :ensure_corresponding_friend_request, only: :create
    
    def index
        @friends = current_user.friends
        @friendships_and_occurrences = current_user.friendships.to_a + current_user.occurrences_as_friend.to_a
        @friends_with_friendships = @friends.map do |friend|
            [friend, 
            @friendships_and_occurrences.select do |fo|
                fo.friend_one_id == friend.id || fo.friend_two.id == friend.id
            end
            ]
        end
    end

    def create
        if @friendship.save
            @friend_request = FriendRequest.find(params[:friend_request_id])
            @friend_request.destroy

            redirect_to friend_requests_path, notice: "Friend successfully added."
        else
            render friend_requests_path, alert: "There was a problem adding your friend."
        end
    end

    def destroy
        if !current_user_in_friendship?(@friendship)
            redirect_to friendships_path, alert: "You cannot destroy the friendships of other users!"
        else
            @friendship.destroy
            redirect_to friendships_path, notice: "Successfully removed user from your friends list."
        end
    end


    private

    def friendship_params
        params.require(:friendship).permit(:friend_one_id, :friend_two_id)
    end

    def ensure_corresponding_friend_request
        unless corresponding_friend_request?(@friendship)
            redirect_to authenticated_root_path, alert: "You can only manage friend requests addressed you yourself!"
        end
    end

    def corresponding_friend_request?(friendship)
        if FriendRequest.where(
            sending_user_id: friendship.friend_one_id,
            receiving_user_id: friendship.friend_two_id).any? &&
            friendship.friend_two_id == current_user.id
           
            return true
        end

        false
    end

    def current_user_in_friendship?(friendship)
        current_user.id == friendship.friend_one_id ||
        current_user.id == friendship.friend_two_id
    end

    def set_friendship
        @friendship = Friendship.find(params[:id])
    end

    def new_friendship
        @friendship = Friendship.new(friendship_params)
    end
end
