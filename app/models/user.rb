class User < ApplicationRecord
  has_many :posts
  has_many :received_friend_requests, class_name: "FriendRequest", foreign_key: "receiving_user_id"
  has_many :sent_friend_requests, class_name: "FriendRequest", foreign_key: "sending_user_id"
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end
