require 'rails_helper'

RSpec.describe "articles/index", :type => :view do

  context "no data" do
    subject { render }
    before :each do
        category = create :category
        post = create :valid_no_draft_post, category: category, tag_list: "TEST_TAG"
        @posts = Post.all.valid.order('created_at DESC')
        @message = "最近の投稿"
    end

    it "being displayed 'Articles' " do
        should match(/Articles/)
    end

    it "being displayed 'Tag Cloud' " do
        should match(/TEST_TAG/)
    end
  end

end
