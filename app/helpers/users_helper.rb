module UsersHelper
  def create_friendship_request_path(user)
    "/users/#{user.id}/invite"
  end

  def friendship_request_link(user)
    if (user != current_user) && (!current_user.outgoing_friends.include? user )
      return link_to 'Send friend request', create_friendship_request_path(user), class: 'profile-link' 
    else
      return ''  
    end
  end
end