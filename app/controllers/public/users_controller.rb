class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:edit]
  before_action :is_user_frozen

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order('created_at DESC')
    @groups = @user.groups.order('created_at DESC')
    favorites = Favorite.where(user_id: params[:id]).pluck(:post_id)
    @favorite_posts = Post.find(favorites).sort_by{ |p| p.created_at }.reverse
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

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "ゲストユーザー"
      redirect_to user_path(current_user), notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません'
    end
  end

  def is_user_frozen
    @user = current_user
    if @user.is_frozen == true
      redirect_to posts_path, alert: 'このアカウントは停止されました'
    end
  end

end
