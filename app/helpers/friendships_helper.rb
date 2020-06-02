module FriendshipsHelper
  def accept_friendship_path(friendship)
    "/friendships/#{friendship.id}/accept"
  end
end
