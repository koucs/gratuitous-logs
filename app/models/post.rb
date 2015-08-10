class Post < ActiveRecord::Base
    has_many :comments, dependent: :destroy
    belongs_to :category

    validates :title, presence: true, length: { minimum: 5 }
    validates :contents, presence: true
    validates :category_id, presence: true

    acts_as_taggable

    escape_char = ["\\", "`",  "*", "_", "{", "}",  "#", "+", "-",  ".", "!" ]

    # 記事内容を20字に省略して表示
    def summary_contents
        self.contents.length > 200 ? contents[0, 200] + '...' : contents
    end

end
