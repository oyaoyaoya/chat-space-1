class MessagesController < ApplicationController

  def index
    @message = Message.new
    @groups = current_user.groups
  end

  def create
    message = Message.new(message_params)

    if message.save
      redirect_to :back
    else
      redirect_to :back, :alert => "#{message.errors.full_messages[0]}"
    end

  end

  def message_params
    params.require(:message).permit(:text).merge(user_id: current_user.id, group_id: params[:group_id])
  end

end
