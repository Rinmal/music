class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @posts = Post.page(params[:page]).order('created_at DESC')
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
  end

# タグを押下するとタグに基づく投稿の一覧を見れる
  def tag
    @tag = Tag.find_by(body: params[:body])
    @posts = @tag.posts.page(params[:page])
  end

end
