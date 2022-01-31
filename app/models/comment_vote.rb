class CommentVote < ApplicationRecord
  validates :author_id, uniqueness: { scope: :comment_id }
  belongs_to :author
  belongs_to :comment

  enum vote_value: %i[zero negative positive]
end
