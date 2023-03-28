class Public::CommentsController < ApplicationController
  # application_controllerに記載
  before_action :ensure_guest_user
  before_action :is_user_frozen

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
    @post = Post.find(params[:post_id])
    @comments = @post.comments
    @comment = Comment.new
    Comment.find(params[:id]).destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

end
