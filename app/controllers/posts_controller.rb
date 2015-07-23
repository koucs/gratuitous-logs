class PostsController < ApplicationController
    USERS = { ENV['BLOG_EDIT_USER'] => ENV['BLOG_EDIT_PASSWD']}

    protect_from_forgery
    before_filter :digest_authentication

    def index
        @posts = Post.all
    end

    def new
        @post = Post.new
    end

    def create
        @post = Post.new(post_params)

        if params[:preview_button] || !@post.save
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

    # POST /posts/convert_mark2html
    # Exchange ( Markdown of Textarea -> HTML for displaying Preview )
    # This Function Only used by AJax
    def convert_mark2html
        if params[:user_id] == "test-user"
            render json: view_context.markdown(params[:contents]).html_safe
        else
            render text: "failed"
        end
    end

    def upload_image
        data=params[:file]

        # File.open('./tmp/'+ data.original_filename, 'wb') do |of|
        #     of.write(data.read)
        # end
        render json: Cloudinary::Uploader.upload(data).to_json
    end

    private
    def post_params
        params.require(:post).permit(:title, :contents, :tag_list)
    end

    def digest_authentication
        authenticate_or_request_with_http_digest do |name|
          USERS[name]
        end
    end

end
