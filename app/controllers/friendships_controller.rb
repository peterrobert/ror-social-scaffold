class FriendshipsController < ApplicationController
    before_action :authenticate_user!

    def index
       @friendships = current_user.pending_friendships
    end

    def create
        
    end

    def destroy
        
    end

    def acceptance
      Friendship.find(params[:id]).accept_friendship
      flash[:notice] = "friendship accepted"

      redirect_to friendships_path
    end
end
