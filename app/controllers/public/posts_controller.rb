class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :post_exist?, only: [:show, :destroy]
  before_action :ensure_guest_user, except: [:index, :show, :tag]
  before_action :is_user_frozen, except: [:index, :tag]

  def index
    @posts = Post.page(params[:page]).order('created_at DESC')
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments
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
    @tag = Tag.find_by(body: params[:body])
    @posts = @tag.posts
    # @post = @tag.posts.page(params[:page])
  end

  private

  def post_params
     params.require(:post).permit(:body)
  end

# 存在しない投稿に飛べないようにする
  def post_exist?
    unless Post.find_by(id: params[:id])
      redirect_to posts_path
    end
  end

# ゲストログイン時の利用制限
  def ensure_guest_user
    if current_user.name == "ゲストユーザー"
      redirect_to user_path(current_user), notice: 'ゲストユーザは閲覧用のみ利用可能です'
    end
  end

# 凍結時の利用制限
  def is_user_frozen
    @user = current_user
    if @user.is_frozen == true
      redirect_to posts_path, alert: 'このアカウントは停止されました'
    end
  end

end
