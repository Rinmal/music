class Admin::CommentsController < ApplicationController

# 非同期通信
  def destroy
    @post = Post.find(params[:post_id])
    @comments = @post.comments
    @comment = Comment.new
    Comment.find(params[:id]).destroy
  end

end
