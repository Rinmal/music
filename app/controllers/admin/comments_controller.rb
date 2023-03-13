class Admin::CommentsController < ApplicationController

  def destroy
    @comments = Comment.all
    @comment = Comment.new
    Comment.find(params[:id]).destroy
    redirect_back fallback_location: root_path
  end

end
