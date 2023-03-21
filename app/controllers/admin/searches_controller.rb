class Admin::SearchesController < ApplicationController

  def search
    if (params[:word])[0] == '#'
      @posts = Tag.search(params[:word]).order('created_at DESC')
    else
      @posts = Post.search(params[:word]).order('created_at DESC')
    end
  end

end
