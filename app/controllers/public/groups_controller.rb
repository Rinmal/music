class Public::GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :group_exist?, only: [:show, :chat]
  before_action :is_matching_login_user, only: [:edit, :update]
  # application_controllerに記載
  before_action :ensure_guest_user, only: [:new, :create, :join]
  before_action :is_user_frozen

  def index
    @groups = Group.all.order('created_at DESC')
    @joinedgroups = current_user.groups.order('created_at DESC')
  end

  def show
    @group = Group.find(params[:id])
    @users = @group.users
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    @group.users << current_user
    if @group.save
      redirect_to group_path(@group), notice: "グループの作成に成功しました"
    else
      render 'new'
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to group_path(@group), notice: "グループ情報を更新しました"
    else
      render 'edit'
    end
  end

# グループ退室
  def destroy
    @group = Group.find(params[:id])
    @group.users.delete(current_user)
    redirect_to groups_path
  end

  def join
    @group = Group.find(params[:group_id])
    @group.users << current_user
    redirect_to group_path(@group)
  end

  def chat
    @group = Group.find(params[:id])
    @messages = @group.messages.order('created_at DESC')
    @message = Message.new
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :group_image)
  end

# 存在しないグループに飛べないようにする
  def group_exist?
    unless Group.find_by(id: params[:id])
      redirect_to groups_path
    end
  end

  def is_matching_login_user
    group = Group.find(params[:id])
    unless current_user.id == group.owner_id
      redirect_to group_path(group)
    end
  end

end
