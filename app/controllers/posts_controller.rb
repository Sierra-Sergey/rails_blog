class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :update_views_counter, only: %i[ show ]
  before_action :authorize, only: %i[new create edit update]
  before_action :not_post_owner , only: %i[ destroy edit update ]

  # GET /posts or /posts.json
  def index
    @posts = Post.all.sort_by {:id}
  end

  # GET /posts/1 or /posts/1.json
  def show
    @comment = Comment.new
  end

  def authors
    @authors = Author.all
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    @post.author_id = current_author.id

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy

    respond_to do |format|
      if @post.destroy
        format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      else
        format.html {redirect_to posts_url}
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    def update_views_counter
      @post.update_column(:views_count, @post.views_count + 1)
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :content, :image, :author_id)
    end

    def not_post_owner
      redirect_to root_url, alert: 'Not your post' if current_author != @post.author
    end
end
