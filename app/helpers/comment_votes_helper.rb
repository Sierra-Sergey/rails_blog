module CommentVotesHelper
  def votes_sum(comment)
    comment.comment_votes.positive.count - comment.comment_votes.negative.count
  end
end
