class ApplicationController < ActionController::Base

  def after_sign_in_path_for(resource)
    if admin_signed_in?
      admin_posts_path
    else
      current_user
      flash[:notice] = "ログインに成功しました"
      posts_path
    end
  end

end
