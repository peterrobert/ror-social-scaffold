class Friendship < ApplicationRecord
  belongs_to :inviter, class_name: "User", foreign_key: "inviter_id"
  belongs_to :invitee, class_name: "User", foreign_key: "invitee_id"

  def accept_friendship
    self.status = true
    self.save
  end
end
