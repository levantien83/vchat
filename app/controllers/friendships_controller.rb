class FriendshipsController < ApplicationController
  def index    
    load_user
    @followings = @user.friends 
    @following_relations = @user.friendships.where(acceptance: false)
    @followers = @user.followers 
    @follower_relations = @user.friend_requests.where(acceptance: false)
    @true_friendships = @user.true_friendships
    @other_users = User.all - @followings - @followers - [@user]

    @true_friend_theads = ["Name", "Email", "Friended at", "Unfriend"]
    @follower_theads = ["Name", "Email", "Requested at", "Accept or Cancel"]
    @following_theads = ["Name", "Email", "Sent at", "Cancel"]
    @other_user_theads = ["Name", "Email", "Created at", "Addfriend"]
  end

  def create
    load_user
    @friendship = @user.friendships.build(:friend_id => params[:friend_id])
    @friendship.acceptance = false
    if @friendship.save
      flash[:notice] = "Friend added"
      redirect_to friendships_path
    else
    flash[:notice] = "Friend added"
      redirect_to friendships_path
    end
  end

  def destroy
    load_user
    @friendship = Friendship.find(params[:id])
    @friendship.destroy
    flash[:notice] = "Let it go, let it goooooooo"
    redirect_to friendships_path
  end

  def update
    load_user
    @friendship = Friendship.find(params[:id])
    @friendship.accept_friend!
    redirect_to friendships_path
  end
end
