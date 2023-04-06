class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).order('created_at DESC')
    @groups = @user.groups.order('created_at DESC')
    @favorite_posts = @user.favorite_posts.page(params[:page]).order('created_at DESC')
  end

# ユーザーの凍結のみ更新可能
  def update
    @user = User.find(params[:id])
    @user.update(update_params)
    redirect_back fallback_location: admin_root_path
  end

  def followings
    user = User.find(params[:id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers
  end

  private

  def update_params
    params.require(:user).permit(:is_frozen)
  end
end
