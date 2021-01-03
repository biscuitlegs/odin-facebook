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

  validates :username, presence: true, uniqueness: true, length: { minimum: 5, maximum: 25 }, allow_blank: false
  validates :first_name, presence: true, length: { maximum: 15 }, allow_blank: false
  validates :last_name, presence: true, length: { maximum: 15 }, allow_blank: false
  validates :email, presence: true, uniqueness: true, length: { maximum: 30 }, allow_blank: false
  validates :password, presence: true, length: { minimum: 6, maximum: 12 }, format: { with: /.*\d.*/ }, if: :password, unless: :from_omniauth?

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
      user.parse_username(auth.info.name)
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
    if self.profile_picture.attached? 
      self.profile_picture.variant(resize_to_fill: [128, 128])
    elsif self.facebook_profile_picture
      self.facebook_profile_picture
    else
      "https://bulma.io/images/placeholders/128x128.png"
    end
  end

  def from_omniauth?
    provider && uid
  end

  def parse_username(full_name)
    simple_name = full_name.gsub(" ", "").downcase
    number = 1
    self.username = "#{simple_name}#{number.to_s}"
    self.valid?

    until self.errors[:username].none?
      number += 1
      self.username = simple_name + number.to_s
      self.valid?
    end

    self.username = "#{simple_name}#{number.to_s}"
  end
  
end
