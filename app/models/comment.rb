class Comment < ApplicationRecord
    belongs_to :post
    belongs_to :user

    validates :body, presence: true, length: { minimum: 5, maximum: 50 }

    def creator
        User.find(self.user_id)
    end
end
