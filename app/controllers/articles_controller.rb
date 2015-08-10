class ArticlesController < ApplicationController
  def index
    @posts = Post.all.order('updated_at DESC')
  end

  def show
    @post = Post.find(params[:id])
  end
end
