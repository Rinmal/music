class Public::CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comments = Comment.all
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = @post.id
    @comment.save
    redirect_back fallback_location: root_path
  end

  def destroy
    @comments = Comment.all
    @comment = Comment.new
    Comment.find(params[:id]).destroy
    redirect_back fallback_location: root_path
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

end
