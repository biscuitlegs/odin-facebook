class Post < ApplicationRecord
    belongs_to :user

    has_many :likes
    has_many :likes_from_users, through: :likes, source: :user
end
