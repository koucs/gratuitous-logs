class Post < ActiveRecord::Base
    has_many :comments, dependent: :destroy
    belongs_to :category

    validates :title, presence: true, length: { minimum: 5 }
    validates :contents, presence: true
    validates :category_id, presence: true

    acts_as_taggable

    escape_char = ["\\", "`",  "*", "_", "{", "}",  "#", "+", "-",  ".", "!" ]

    # 記事内容を省略して返す
    # → #, \ は省略（heading, エスケープで多く使うので）
    # → 200文字の文字数制限
    def summary_contents
        output = self.contents.gsub(/(\#|\\)/, "")
        output.length > 200 ? output[0, 200] + '...' : output
    end

end
