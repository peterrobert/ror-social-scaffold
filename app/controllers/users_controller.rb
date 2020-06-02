class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end

  def send_friendship_request
    friendship = Friendship.new
    friendship.inviter = current_user
    friendship.invitee = User.find(params[:id])
    friendship.status = false
    flash[:notice] = if friendship.save
                       'Friendship request sent'
                     else
                       'There was an error sending the friendship request'
                     end
    redirect_to users_path
  end
end
