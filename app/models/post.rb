class Post < ActiveRecord::Base
    validates :title, presence: true, length: { minimum: 5}
    validates :contents, presence: true
end
