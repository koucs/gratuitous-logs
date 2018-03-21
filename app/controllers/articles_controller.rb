class ArticlesController < ApplicationController

  before_action :before_load_tags

  PER = ENV['ARTICLE_NUM_PER_PAGE']

  def index
    @posts = Post.all.valid.order('created_at DESC')
                 .page(params[:page]).per(PER)
    @message = "最近の投稿"
    prepare_meta_tags( title: "最近の投稿一覧" )
    respond_to do |format|
      format.html
      format.rss
    end
  end

  def show
    @post = Post.valid.find(params[:id])
    prepare_meta_tags( title: @post.title, image: @post.category.image_url )
    @latest_posts = Post.all.valid.order('created_at DESC').limit(5)
  end

  # Find by Category_ID
  def list_by_category
    @category = Category.find(params[:category_id])
    @posts = Post.valid.where(category_id: @category.id)
                 .page(params[:page]).per(PER)

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
                 .page(params[:page])
                 .per(PER)

    if @posts.count != 0
      @message = '"' + @tag.to_s + '" タグに関連する投稿'
      prepare_meta_tags( title: "タグに関連する投稿一覧" )
      render :index
    else
      @posts = Post.all.valid.order('created_at DESC')
                   .page(params[:page]).per(PER)
      @message = "最近の投稿"

      prepare_meta_tags( title: "最近の投稿一覧" )
      respond_to do |format|
        format.html
        format.rss
      end
    end
  end


  private
  def before_load_tags
    # タグ数をlimitで指定
    # http://www.workabroad.jp/posts/2151
    @tags = Post.tag_counts_on(:tags, limit: ENV['TAG_CLOUD_PER_PAGE'].to_i)
  end
end
