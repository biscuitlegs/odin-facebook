class FriendRequest < ApplicationRecord
    belongs_to :sending_user, class_name: "User"
    belongs_to :receiving_user, class_name: "User"
    validate :must_have_unique_sender_and_receiver

    def must_have_unique_sender_and_receiver
        if FriendRequest.where("sending_user_id = ? AND receiving_user_id = ?", self.sending_user_id, self.receiving_user_id).any?
            errors.add(:sending_user_id, "Must be a unique pair with :receiving_user_id")
            errors.add(:receiving_user_id, "Must be a unique pair with :sending_user_id")
        end
        if FriendRequest.where(sending_user_id: self.receiving_user_id, receiving_user_id: self.sending_user_id).any?
            errors.add(:sending_user_id, "Must be a unique pair with :receiving_user_id")
            errors.add(:receiving_user_id, "Must be a unique pair with :sending_user_id")
        end
    end

    def self.from_to(sender, receiver)
        if self.where(sending_user_id: sender.id, receiving_user_id: receiver.id).any?
            return true
        end

        false
    end
end
