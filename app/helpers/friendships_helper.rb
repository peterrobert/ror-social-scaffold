module FriendshipsHelper

    def accept_friendship_path(friendship)

      "/friendships/#{friendship.id}/accept"

    end
    
    def pending_friendship_list 
      
        if @friendships 

    
        else

        end  
    end
end
