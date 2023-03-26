class Public::CommentsController < ApplicationController
  before_action :ensure_guest_user

# 非同期通信
  def create
    @post = Post.find(params[:post_id])
    @comments = @post.comments
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = @post.id
    if @comment.save
      @comment = Comment.new
    end
  end

# 非同期通信
  def destroy
    @comments = Comment.all
    @comment = Comment.new
    Comment.find(params[:id]).destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

# ゲストログイン時の利用制限
  def ensure_guest_user
    if current_user.name == "ゲストユーザー"
      redirect_to user_path(current_user), notice: 'ゲストユーザーは閲覧用のみ利用可能です'
    end
  end

end
