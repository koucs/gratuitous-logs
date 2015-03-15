class PostsController < ApplicationController
    def index
        @posts = Post.all
    end

    def new
        @post = Post.new
    end

    def create
        @post = Post.new(post_params)

        if @post.save
           redirect_to @post
       else
            render 'new'
        end
    end

    def show
        @post = Post.find(params[:id])
        @test_code =<<-EOS
 ``` ruby
def exit
    puts "Hello, world!"
end
```

``` c
int main(){
    int ad;
    exit
}
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
