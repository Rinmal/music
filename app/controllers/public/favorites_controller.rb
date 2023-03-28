class Public::FavoritesController < ApplicationController
  # application_controllerに記載
  before_action :ensure_guest_user
  before_action :is_user_frozen

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

end
