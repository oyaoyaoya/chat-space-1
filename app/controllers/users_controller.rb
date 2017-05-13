class UsersController < ApplicationController
  def update
    user = User.find(current_user.id)
    user.update(user_params)
    redirect_to :root, :notice => "アカウントの更新が完了しました。"
  end

private
  def user_params
    params.require(:user).permit(:name, :email)
  end

end
