class CommentVotesController < ApplicationController
  before_action :authorize, only: %i[ vote ]
  before_action :set_comment_vote, only: %i[ vote ]

  def vote
    if vote_exist?
      update_vote
    else
      create_vote
    end
    respond_to do |format|
      format.js
    end
    # redirect_to @vote.comment.post
  end

  private

  def set_comment_vote
    @vote = CommentVote.find_by(author_id: current_author.id, comment_id: vote_params[:comment_id])
  end

  def vote_params
    params.require(:comment_vote).permit(:comment_id, :vote_value)
  end

  def create_vote
    @vote = current_author.comment_votes.build(vote_params)
    @vote.save
  end

  def update_vote
    if @vote[:vote_value] == vote_params[:vote_value]
      @vote.destroy
    else
      @vote.update(vote_params)
    end
  end

  def vote_exist?
    CommentVote.where(author_id: current_author.id, comment_id: vote_params[:comment_id]).exists?
  end
end
