class PostsController < ApplicationController
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

    # GET /posts/convert_mark2html
    def convert_mark2html
        if params[:user_id] == "test-user"
            render json: view_context.markdown(params[:contents]).html_safe
        else
            render text: "failed"
        end
    end

    private
        def post_params
            params.require(:post).permit(:title, :contents, :tag_list)
        end

end
