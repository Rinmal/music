class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_user_frozen, except: [:index]

  def index
    @posts = Post.all.order('created_at DESC')
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = Comment.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post), notice: "投稿に成功しました"
    else
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  def tag
    @user = current_user
    @tag = Tag.find_by(body: params[:body])
    @posts = @tag.posts
    # @post = @tag.posts.page(params[:page])

  end

  private

  def post_params
     params.require(:post).permit(:body)
  end

  def is_user_frozen
    @user = current_user
    if @user.is_frozen == true
      redirect_to posts_path, alert: 'このアカウントは停止されました'
    end
  end

end
