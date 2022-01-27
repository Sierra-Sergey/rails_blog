module ApplicationHelper
  include Pagy::Frontend

  def render_modal?
    current_author.nil? && cookies[:visits].to_i > 5
  end
end
