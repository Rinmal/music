class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    @groups = @user.groups
  end

  def update
    @user = User.find(params[:id])
    @user.update(update_params)
    redirect_back fallback_location: admin_root_path
  end

  private

  def update_params
    params.require(:user).permit(:is_frozen)
  end
end
