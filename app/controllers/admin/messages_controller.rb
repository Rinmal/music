class Admin::MessagesController < ApplicationController

  def destroy
    @message = Message.find(params[:id]).destroy
    redirect_back fallback_location: root_path
  end

end
