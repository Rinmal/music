class ApplicationController < ActionController::Base

  def after_sign_in_path_for(resource)
    if admin_signed_in?
      admin_posts_path
    else
      current_user
      flash[:notice] = "ログインに成功しました"
      posts_path
    end
  end

  # ゲストログイン時の利用制限
  def ensure_guest_user
    if current_user.name == "ゲストユーザー"
      redirect_to posts_path, notice: 'ゲストユーザは閲覧用のみ利用可能です'
    end
  end

  # 凍結時の利用制限
  def is_user_frozen
    @user = current_user
    if @user.is_frozen == true
      redirect_to posts_path, alert: 'このアカウントは停止されました'
    end
  end

end
