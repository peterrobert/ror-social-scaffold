class FriendshipsController < ApplicationController
    before_action :authenticate_user!

    def index
       @friendships = current_user.pending_friendships
    end

    def create
       @friendship = Friendship.new(friendship_params)
       if @friendship.save
         flash[:notice] = 'friendship request sent'
       else
         flash[:notice] = 'there was an error sending the friendship request'
       end
       redirect_to users_path
    end

    def destroy
      @friendship = Friendship.find(params[:id])
      if @friendship.destroy 
        flash[:notice] = 'the friendship request was declined'
      else
        flash[:notice] = 'there was an error declining the friendship request'
      end
      redirect_to friendships_path
    end

    def acceptance
      Friendship.find(params[:id]).accept_friendship
      flash[:notice] = "friendship accepted"

      redirect_to friendships_path
    end

    private

    def friendship_params
      params.require(:friendship).permit(:id, :invitee, :inviter, :status)
    end
end
