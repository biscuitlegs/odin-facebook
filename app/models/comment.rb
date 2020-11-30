class Comment < ApplicationRecord
    belongs_to :post
    belongs_to :user

    def creator
        User.find(self.user_id)
    end
end
