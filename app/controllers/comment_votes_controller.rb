class CommentVotesController < ApplicationController
  before_action :set_comment_vote, only: %i[ update ]
  before_action :authorize, only: %i[ create update ]

  def create
    @vote = current_author.comment_votes.build(vote_params)
    @vote[:author_id] = current_author.id
      if @vote.save
        redirect_to @vote.comment.post, notice: 'VOTE accepted'
      end
  end

  def update
    if @vote.vote_value == vote_params[:vote_value]
      @vote.destroy
    else
      @vote.update(vote_params)
    end
    redirect_to @vote.comment.post, notice: 'VOTE changed'
  end

  private

  def set_comment_vote
    @vote = current_author.comment_votes.find{:comment_id == :comment_id}
  end

  def vote_params
    params.require(:comment_vote).permit(:comment_id, :vote_value)
  end
end
