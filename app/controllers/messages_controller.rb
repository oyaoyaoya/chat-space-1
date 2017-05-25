class MessagesController < ApplicationController

  def index
    @groups = current_user.groups
    @group = Group.find(params[:group_id])
    @message = Message.new
    @messages = @group.messages.order('created_at DESC')
  end

  def create
    message = Message.new(message_params)
    if message.save
      redirect_to group_messages_path(message_params[:group_id])
    else
      redirect_to group_messages_path(message_params[:group_id]), :alert => "テキストを入力してください"
    end
  end

  def message_params
    params.require(:message).permit(:text).merge(user_id: current_user.id, group_id: params[:group_id])
  end

end
