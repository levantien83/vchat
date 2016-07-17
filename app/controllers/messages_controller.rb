class MessagesController < ApplicationController
  def show
    @message = Message.find params[:id]    
  end

  def sent
    load_user
    @messages = @user.sent_messages.order(created_at: :desc)
    @theads = ["From", "To", "Body", "Read at"]
  end

  def recieved
    load_user
    @messages = @user.recieved_messages.order(created_at: :desc) 
    @theads = ["From", "To", "Action"]
  end   

  def new
    load_user
    @message = Message.new
    @friends = @user.true_friends
  end

  def create
    load_user
    @message = Message.new message_params
    @message.from_id = @user.id
    if @message.save      
      flash[:notice] = "Message sent"
      redirect_to sent_user_messages_path
    else
      flash[:error] = "Message error"
      render 'new'
    end
  end

  def index
    @messages = Message.all.order(created_at: :desc)
    @theads = ["From", "To", "Body", "Read at"]
  end

  private

  def message_params
    params.require(:message).permit(:to_id, :body)
  end
end
