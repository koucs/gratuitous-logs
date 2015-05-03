class Post < ActiveRecord::Base
    has_many :comments, dependent: :destroy
    belongs_to :category

    validates :title, presence: true, length: { minimum: 5}
    validates :contents, presence: true

    acts_as_taggable


    # 記事内容を20字に省略して表示
    def summary_contents
        if self.contents.length > 20
            contents[0, 20] + '...'
        else
            contents
        end
    end

end
