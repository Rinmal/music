class Admin::CommentsController < ApplicationController

# 非同期通信
  def destroy
    @comments = Comment.all
    @comment = Comment.new
    Comment.find(params[:id]).destroy
  end

end
