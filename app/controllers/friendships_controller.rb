class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def index
    @friendships = current_user.pending_friendships
  end

  def create
    @friendship = Friendship.new(friendship_params)
    flash[:notice] = if @friendship.save
                       'friendship request sent'
                     else
                       'there was an error sending the friendship request'
                     end
    redirect_to users_path
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    flash[:notice] = if @friendship.destroy
                       'the friendship request was declined'
                     else
                       'there was an error declining the friendship request'
                     end
    redirect_to friendships_path
  end

  def acceptance
    friendship = Friendship.find(params[:id])
    Friendship.create(inviter: friendship.invitee, invitee: friendship.inviter, status: true)
    friendship.accept_friendship
    flash[:notice] = 'friendship accepted'

    redirect_to friendships_path
  end

  private

  def friendship_params
    params.require(:friendship).permit(:id, :invitee, :inviter, :status)
  end
end
