class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).order('created_at DESC')
    @groups = @user.groups.order('created_at DESC')
    favorites = Favorite.where(user_id: params[:id]).pluck(:post_id)
    @favorite_posts = Post.find(favorites).sort_by{ |p| p.created_at }.reverse
  end

# ユーザーの凍結のみ更新可能
  def update
    @user = User.find(params[:id])
    @user.update(update_params)
    redirect_back fallback_location: admin_root_path
  end

  private

  def update_params
    params.require(:user).permit(:is_frozen)
  end
end
