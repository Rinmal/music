class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @posts = Post.page(params[:page]).order('created_at DESC')
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
  end

  def tag
    @tag = Tag.find_by(body: params[:body])
    @posts = @tag.posts
    # @post = @tag.posts.page(params[:page])
  end

end
