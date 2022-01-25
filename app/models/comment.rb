class Comment < ApplicationRecord
  belongs_to :author
  belongs_to :post, counter_cache: true
  validates :body, presence: true

  enum status: %i[unpublished published]

  scope :published, -> { where(status: :published) }
  scope :unpublished, -> { where(status: :unpublished) }

  def edited?
    self.created_at != self.updated_at
  end
end
