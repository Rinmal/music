class Public::FavoritesController < ApplicationController
  before_action :ensure_guest_user

# 非同期通信
  def create
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.new(post_id: params[:post_id])
    favorite.save
  end

# 非同期通信
  def destroy
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: @post.id)
    favorite.destroy
  end

  private

# ゲストログイン時の利用制限
  def ensure_guest_user
    if current_user.name == "ゲストユーザー"
      redirect_to user_path(current_user), notice: 'ゲストユーザーは閲覧用のみ利用可能です'
    end
  end
end
