class GroupsController < ApplicationController

  def new
    @group = Group.new
  end

  def edit
    @group = Group.find(params[:id])
    @belonged_user = @group.users
    @users = @group.users
  end

  def index
    @message = Message.new
    @groups = current_user.groups
  end

  def create
    group = Group.new(group_params)
    # validationの結果による動作の条件分岐
    # クリア->
        # member_params[:user_id]の中身があるときだけ保存
    # 失敗->エラーメッセージとともにリダイレクト
    if group.save
      redirect_to :root
    else
      @group = Group.new
      @error_group = group
      render 'new'
    end
  end

  def update
    group = Group.find(params[:id])
    group.update(group_params)
    if group.valid?
      redirect_to :root
    else
      redirect_to :new_group_path
    end
  end

  def search
    @users = User.where('name LIKE(?)', "%#{params[:input]}%")
    respond_to do |format|
        format.json
    end
  end


private
  def group_params
    params.require(:group).permit(:name, {:user_ids => []})
  end

end
