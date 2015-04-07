class Post < ActiveRecord::Base
    has_many :comments, dependent: :destroy
    belongs_to :category

    validates :title, presence: true, length: { minimum: 5}
    validates :contents, presence: true

    acts_as_taggable
end
