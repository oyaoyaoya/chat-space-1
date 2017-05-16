class GroupsController < ApplicationController

  def new
    @group = Group.new
  end

  def edit
  end

  def create
    group = Group.create(group_params)
    member_params[:user_id].each do |id|
      Member.create(user_id: id, group_id: group.id)
    end
    redirect_to :root
  end

private
  def member_params
    params.require(:member).permit(:user_id => [])
  end

  def group_params
    params.require(:group).permit(:name)
  end

end
