class ArticlesController < ApplicationController
  def index
    @posts = Post.all.valid.order('created_at DESC')
    @message = "最近の投稿"

    @tags = Post.tag_counts_on(:tags)

    prepare_meta_tags( title: "最近の投稿一覧" )
    respond_to do |format|
      format.html
      format.rss
    end
  end

  def show
    @post = Post.find(params[:id])
    prepare_meta_tags( title: @post.title + " | 記事" )
  end

  # Find by Category_ID
  def list_by_category
    @category = Category.find(params[:category_id])
    @posts = Post.valid.where(category_id: @category.id)
    if @posts.count != 0
      @message = '"' + @category.name + '"カテゴリに関連する投稿'
    else
      @message = '"' + @category.name + '"カテゴリに関連する投稿はありません'
    end

    prepare_meta_tags( {title: "カテゴリに関連する投稿一覧"} )
    render :index
  end

  # Find by TAG name ( acts_as_taggable )
  def list_by_tag
    @tag = params[:tag_name]
    @posts = Post.valid.tagged_with(@tag)
    if @posts.count != 0
      @message = '"' + @tag.to_s + '" タグに関連する投稿'
    else
      @message = '"' + @tag.to_s + '" タグに関連する投稿はありません'
    end

    prepare_meta_tags( title: "タグに関連する投稿一覧" )
    render :index
  end

end
