class Public::SearchesController < ApplicationController

  def search
    if (params[:word])[0] == '#'
      @posts = Tag.search(params[:word]).page(params[:page]).order('created_at DESC')
    else
      @posts = Post.search(params[:word]).page(params[:page]).order('created_at DESC')
    end
  end

end
