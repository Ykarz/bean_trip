class ProfilesController < ApplicationController
  def show
    # 現在ログインしているユーザーの過去の豆投稿を取得し、@beansに代入
    @beans = current_user.beans.order(created_at: :desc)
  end

  def edit
    # 現在ログインしているユーザーの情報を取得し、@userに代入
    @user = User.find(current_user.id)
  end

  def update
    # 現在ログインしているユーザーの情報を取得し、@userに代入
    @user = User.find(current_user.id)

    # user_params（ストロングパラメータ）で@userを更新
    if @user.update(user_params)
      # 更新に成功した場合、プロフィール表示ページへリダイレクトし、成功メッセージを表示
      redirect_to profile_path, notice: t('profiles.update.success')
    else
      # 更新に失敗した場合、編集フォームを再表示し、エラーメッセージを表示
      flash.now[:alert] = t('profiles.update.failure')
      render :edit, status: :unprocessable_entity
    end
  end

  private

  # ストロングパラメータの設定
  def user_params
    params.require(:user).permit(:name, :email, :avatar, :avatar_cache)
  end
end
