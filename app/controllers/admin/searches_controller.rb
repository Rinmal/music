class Admin::SearchesController < ApplicationController

  def search
    # 「＃」の有無でキーワード検索かタグ検索かを判別
    if (params[:word])[0] == '#'
      @posts = Tag.search(params[:word]).page(params[:page]).order('created_at DESC')
    else
      @posts = Post.search(params[:word]).page(params[:page]).order('created_at DESC')
    end
  end

end
