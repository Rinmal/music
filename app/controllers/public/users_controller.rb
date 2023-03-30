class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :update]
  before_action :user_exist?, only: [:show]
  # application_controllerに記載
  before_action :ensure_guest_user, only: [:edit, :update]
  before_action :is_user_frozen, except: [:show]

  def show
    @user = User.find(params[:id])

    # 凍結されたユーザーは自分のページ以外に遷移できないように
    if (current_user.is_frozen == true) && (@user.id != current_user.id)
      redirect_to posts_path, alert: 'このアカウントは停止されました'
    else
      @posts = @user.posts.page(params[:page]).order('created_at DESC')
      @groups = @user.groups.order('created_at DESC')
      @favorite_posts = @user.favorite_posts.page(params[:page]).order('created_at DESC')
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "プロフィールを更新しました"
    else
      render "edit"
    end
  end

  def unsubscribe
    @user = User.find(params[:user_id])
    unless @user.id == current_user.id
      redirect_to posts_path
    end
  end

# 論理削除による退会機能
  def is_deleted
    @user = current_user
    if @user.update(is_deleted: true)
      reset_session
      redirect_to root_path, notice: "退会しました"
    else
      render "unsubscribe"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def is_matching_login_user
    user_id = params[:id].to_i
    unless user_id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end

# 存在しないユーザーに飛べないようにする
  def user_exist?
    unless User.find_by(id: params[:id])
      redirect_to posts_path
    end
  end

end
