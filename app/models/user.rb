class User < ApplicationRecord
  has_many :posts

  has_many :friendships, foreign_key: "friend_one_id"
  has_many :occurrences_as_friend, class_name: "Friendship", foreign_key: "friend_two_id"
  

  has_many :received_friend_requests, class_name: "FriendRequest", foreign_key: "receiving_user_id"
  has_many :sent_friend_requests, class_name: "FriendRequest", foreign_key: "sending_user_id"

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def friends
    friendships = self.friendships.to_a + self.occurrences_as_friend.to_a
    users = friendships.map do |friendship|
      if friendship.friend_one_id == self.id
        User.find(friendship.friend_two_id)
      else
        User.find(friendship.friend_one_id)
      end 
    end

    users
  end
end
