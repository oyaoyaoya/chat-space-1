class UsersController < ApplicationController
  def update
    user = User.find(current_user.id)
    user.update(user_params)

    unless user.valid?
      redirect_to :edit_user_registration, :alert => "更新に失敗しました。入力しなおしてください"
    else
      redirect_to :root , :notice => "アカウントの更新が完了しました。"
    end

  end

private
  def user_params
    params.require(:user).permit(:name, :email)
  end

end
