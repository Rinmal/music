class Admin::GroupsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @groups = Group.all.order('created_at DESC')
  end

  def show
    @group = Group.find(params[:id])
    @users = @group.users
  end

  def chat
    @group = Group.find_by(id: params[:id])
    @messages = @group.messages
  end

end
