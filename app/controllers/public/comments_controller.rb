class Public::CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comments = @post.comments
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = @post.id
    if @comment.save
      @comment = Comment.new
    end
  end

  def destroy
    @comments = Comment.all
    @comment = Comment.new
    Comment.find(params[:id]).destroy
    # redirect_back fallback_location: root_path
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

end
