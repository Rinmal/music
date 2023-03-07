class Public::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    @groups = @user.groups
  end

  def edit
  end
end
