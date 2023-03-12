class Public::FavoritesController < ApplicationController
  def index
    favorites = Favorite.where(user_id: params[:user_id]).pluck(:post_id)
    @posts = Post.find(favorites)
  end

  def create
    favorite = current_user.favorites.new(post_id: params[:post_id])
    favorite.save
    redirect_back fallback_location: root_path
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: @post.id)
    favorite.destroy
    redirect_back fallback_location: root_path
  end
end
