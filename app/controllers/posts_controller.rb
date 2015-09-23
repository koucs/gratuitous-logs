class PostsController < ApplicationController
    USERS = { ENV['BLOG_EDIT_USER'] => ENV['BLOG_EDIT_PASSWD']}

    protect_from_forgery

    # DIGEST Auth
    before_filter :digest_authentication

    # --------------------------------------------------
    #     About Post Model
    # --------------------------------------------------

    def index
        @posts = Post.all
        @categories = Category.all

        @new_category = Category.new
    end

    def new
        @post = Post.new
    end

    def create
        @post = Post.new(post_params)

        if !@post.save
            render 'new'
        else
           redirect_to @post
       end

    end

    def show
        @post = Post.find(params[:id])
    end

    def edit
        @post = Post.find(params[:id])
    end

    # PATCH /posts/:id
    # PUT   /posts/:id
    def update
        @post = Post.find(params[:id])

        if @post.update_attributes(post_params)
            redirect_to @post
        else
            render 'edit'
        end
    end

    # DELETE /posts/:id
    def destroy
      @post = Post.find(params[:id])
      @post.destroy

      redirect_to posts_path
    end

    # --------------------------------------------------
    #     About Category Model
    # --------------------------------------------------

    # POST /category/create
    def create_category
        @new_category = Category.new(category_params)
        @new_category.save
        redirect_to posts_path
    end

    def update_category
        @category = Category.find(params[:id])

        @category.update_attributes(category_params)
        redirect_to posts_path
    end

    def remove_category
        @category = Category.find(params[:id])
        @category.destroy

        redirect_to posts_path
    end

    # --------------------------------------------------
    #     Others
    # --------------------------------------------------

    # POST /posts/convert_mark2html
    # Exchange ( Markdown of Textarea -> HTML for displaying Preview )
    # This Function Only used by AJax
    def convert_mark2html
        if params[:user_id] == "test-user"
            if params[:contents]
                render json: view_context.markdown(params[:contents]).html_safe
            else
                render json: nil
            end
        else
            render text: "failed"
        end
    end

    # POST /posts/upload_image
    # Upload Image by Drag & Drop to creating posts form ( /posts/new )
    # This Function use for Cloudinary (heroku)
    def upload_image
        data=params[:file]
        render json: Cloudinary::Uploader.upload(data).to_json
    end


    # --------------------------------------------------
    #     Private
    # --------------------------------------------------

    private
    def post_params
        params.require(:post).permit(:title, :contents, :tag_list, :category_id, :is_valid, :is_draft)
    end

    def category_params
        params.require(:category).permit(:name, :description, :image_url)
    end

    def digest_authentication
        authenticate_or_request_with_http_digest do |name|
          USERS[name]
        end
    end

end
