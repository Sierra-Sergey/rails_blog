class Post < ApplicationRecord
  validates :title, presence: true, length: { in: 3..30 }
  validates :content, presence: true
  belongs_to :author
end
