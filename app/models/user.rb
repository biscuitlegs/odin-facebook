class User < ApplicationRecord

  has_one_attached :profile_picture, dependent: :destroy

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

  has_many :friendships, foreign_key: "friend_one_id", dependent: :destroy
  has_many :occurrences_as_friend, class_name: "Friendship", foreign_key: "friend_two_id"
  

  has_many :received_friend_requests, class_name: "FriendRequest", foreign_key: "receiving_user_id", dependent: :destroy
  has_many :sent_friend_requests, class_name: "FriendRequest", foreign_key: "sending_user_id", dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, :confirmable, omniauth_providers: %i[facebook]

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

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.parse_name(auth.info.name)
      user.facebook_profile_picture = auth.info.image
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def parse_name(name)
    self.first_name = name.split(" ").first
    self.last_name = name.split(" ").last
  end

  def primary_profile_picture
    if self.facebook_profile_picture
      self.facebook_profile_picture
    elsif self.profile_picture.attached?
      self.profile_picture
    else
      "https://bulma.io/images/placeholders/64x64.png"
    end
  end

end
