class GroupsController < ApplicationController

  def new
    @group = Group.new
  end

  def edit
    @group = Group.find(params[:id])
    belonged_user = @group.users
    belonged_user_id = []
    # すでにグループに所属しているユーザーのidを配列で返す
    belonged_user.map do |user|
      belonged_user_id << user.id
    end
    # グループに所属していないユーザー一覧をビューで表示するため
    @users = User.where.not(id: belonged_user_id)
  end

  def show
    @groups = Group.all
    @group = Group.find(params[:id])
    @message = Message.new
  end

  def create
    group = Group.create(group_params)
    # validationの結果による動作の条件分岐
    # クリア->
        # member_params[:user_id]の中身があるときだけ保存
    # 失敗->エラーメッセージとともにリダイレクト
    if group.valid?
      member_params[:user_id].each do |id|
        Member.create(user_id: id, group_id: group.id) if id.present?
      end
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
      member_params[:user_id].each do |id|
        Member.create(user_id: id, group_id: group.id) if id.present?
      end
      redirect_to :root
    else
      @group = Group.find(params[:id])
      @error_group = group
      belonged_user = @group.users
      belonged_user_id = []
      belonged_user.map do |user|
        belonged_user_id << user.id
      end
      @users = User.where.not(id: belonged_user_id)
      render 'edit'
    end
  end

private
  def member_params
    members = params.require(:member).permit(user_id: [])
  end

  def group_params
    params.require(:group).permit(:name)
  end

end
