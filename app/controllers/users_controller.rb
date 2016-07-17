class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def home
    if session[:user_id]
      redirect_to recieved_user_messages_path(current_user.id)
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      session[:user_id] = @user.id
      redirect_to recieved_user_messages_path(current_user.id), notice: "Account created"
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

end
