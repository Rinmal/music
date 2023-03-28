class Public::MessagesController < ApplicationController
  # application_controllerに記載
  before_action :ensure_guest_user
  before_action :is_user_frozen

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

end
