class Admin::GroupsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    @users = @group.users
  end

  def chat
    @group = Group.find_by(id: params[:id])
    if @group.present?
      @messages = @group.messages
    else
      redirect_to posts_path
    end
  end

end
