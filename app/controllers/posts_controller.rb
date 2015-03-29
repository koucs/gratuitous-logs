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
        @test_code =<<-EOS
 ``` rb
import pika

class MessageQueueService(object):

    def log(self, message, queue, host, direction=MessageQueueLog.RECEIVED):
        message_log = MessageQueueLog.objects.create(
                queue=queue,
                host=host,
                message=message,
                direction=direction
            )
        return message_log
```
        EOS
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

    private
        def post_params
            params.require(:post).permit(:title, :contents)
        end

end
