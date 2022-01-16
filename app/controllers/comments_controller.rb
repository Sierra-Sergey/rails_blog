class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    # redirect_to post_path(@post)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Comment was successfully created." }
        # format.json { render :show, status: :created, location: @comment }
      else
        format.html { redirect_to @post }
        # format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @comment.post, notice: "Comment was successfully destroyed." }
    end

  end

  private
  def comment_params
    params.require(:comment).permit(:body, :status, :post_id, :author_id)
  end
end
