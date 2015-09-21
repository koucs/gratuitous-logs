class ArticlesController < ApplicationController
  def index
    @posts = Post.all.order('updated_at DESC')
    @message = "最近の投稿"
    respond_to do |format|
      format.html
      format.rss
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  # Find by Category_ID
  def list_by_category
    @category = Category.find(params[:category_id])
    @posts = Post.where(category_id: @category.id)
    if @posts.count != 0
      @message = '"' + @category.name + '"カテゴリに関連する投稿'
    else
      @message = '"' + @category.name + '"カテゴリに関連する投稿はありません'
    end
    render :index
  end

  # Find by TAG name ( acts_as_taggable )
  def list_by_tag
    @tag = params[:tag_name]
    @posts = Post.tagged_with(@tag)
    if @posts.count != 0
      @message = '"' + @tag.to_s + '" タグに関連する投稿'
    else
      @message = '"' + @tag.to_s + '" タグに関連する投稿はありません'
    end
    render :index
  end

end
