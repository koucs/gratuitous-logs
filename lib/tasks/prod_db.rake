namespace :prod_db do
    desc "Test task for production_local"
    task test: :environment do
        test
    end
end

# Check if production_local environment works
def test
    ActiveRecord::Base.establish_connection(:production_local)
    puts "This is test"
    post = Post.last
    puts "#{post.id} #{post.title}"
end
