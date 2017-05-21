class MessagesController < ApplicationController

  def index
    @message = Message.new
    @groups = Group.all
  end

  def create
    message = Message.create(message_params)

    unless message.valid?
      redirect_to :back, :alert => "#{message.errors.full_messages[0]}"
    else
      redirect_to :back
    end

  end

  def message_params
    params.require(:message).permit(:text).merge(user_id: current_user.id, group_id: params[:group_id])
  end

end
