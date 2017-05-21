class MessagesController < ApplicationController

  def index
    @message = Message.new
    @groups = Group.all
  end

  def create
  end

end
