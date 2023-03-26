class Public::MessagesController < ApplicationController
  before_action :ensure_guest_user

  def create
    @message = Message.new(message_params)
    @message.save
    redirect_back fallback_location: root_path
  end

  def destroy
    @message = Message.find(params[:id]).destroy
    redirect_back fallback_location: root_path
  end

  private

  def message_params
    params.require(:message).permit(:user_id, :group_id, :message).merge(user_id: current_user.id)
  end

# ゲストログイン時の利用制限
  def ensure_guest_user
    if current_user.name == "ゲストユーザー"
      redirect_to user_path(current_user), notice: 'ゲストユーザーは閲覧用のみ利用可能です'
    end
  end
end
