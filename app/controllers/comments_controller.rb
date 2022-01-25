class CommentsController < ApplicationController
  before_action :set_post, only: %i[ edit create update destroy ]
  before_action :set_comment, only: %i[ edit update destroy ]
  before_action :authorize, only: %i[ create edit destroy ]
  before_action :access_denied, only: %i[ destroy edit update ]

  def index
    redirect_to Post.find(params[:post_id])
  end

  def edit
    redirect_to @post, alert: "Can't be edited" if deny_edit(@comment)
  end

  def create
    @comment = @post.comments.create(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @post, notice: "Comment was successfully created." }
      else
        format.html { render 'posts/show', status: :unprocessable_entity }
      end
    end
  end

  def publish
    @comment = Comment.find(params[:comment_id])
    @comment.update_column(:status, :published)
    redirect_to @comment.post
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to post_url(@comment.post), notice: "Comment was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @comment.post, notice: "Comment was successfully destroyed." }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :post_id, :author_id)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def access_denied
    redirect_to @post, alert: 'Not your comment' unless current_author == @comment.author
  end
end
