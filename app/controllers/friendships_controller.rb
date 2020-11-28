class FriendshipsController < ApplicationController
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
        @friendship = Friendship.new(friendship_params)

        if @friendship.save
            @friend_request = FriendRequest.find(params[:friend_request_id])
            @friend_request.destroy

            redirect_to friend_requests_path, notice: "Friend successfully added."
        else
            render friend_requests_path, alert: "There was a problem adding your friend."
        end
    end

    def destroy
        @friendship = Friendship.find(params[:id])
        @friendship.destroy

        redirect_to friendships_path, notice: "Successfully removed user from your friends list."
    end


    private

    def friendship_params
        params.require(:friendship).permit(:friend_one_id, :friend_two_id)
    end
end
