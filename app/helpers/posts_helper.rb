module PostsHelper
  def post_author?(post)
    current_author == post.author
  end
end
