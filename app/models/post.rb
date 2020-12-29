class Post < ApplicationRecord
    belongs_to :user
    has_many :comments, dependent: :destroy

    has_many :likes, dependent: :destroy
    has_many :likes_from_users, through: :likes, source: :user

    validates :body, presence: true, length: { minimum: 5, maximum: 150 }
end
