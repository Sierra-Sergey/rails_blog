class ApplicationController < ActionController::Base

  private
  def current_author
    @current_author ||= Author.find(session[:author_id]) if session[:author_id]
  end
  helper_method :current_author

  def authorize
    redirect_to login_url, alert: 'Not authorized' if current_author.nil?
  end

  def deny_edit(comment)
    Time.now - comment.created_at > 1.hour ||
    current_author != comment.author
  end
  helper_method :deny_edit

  def set_visits
    cookies[:visits] = cookies[:visits].present? ? cookies[:visits].to_i + 1 : 1
  end
end
