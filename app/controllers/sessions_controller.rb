class SessionsController < ApplicationController
  before_action :loged_in?, only: %i[ new create ]

  def new
  end

  def create
    author = Author.find_by_email(params[:email])
    if author && author.authenticate(params[:password])
      session[:author_id] = author.id
      redirect_to root_url, notice: 'Logged in'
    else
      flash.now.alert = 'Email or password is invalid'
      render 'new'
    end
  end

  def destroy
    session[:author_id] = nil
    redirect_to root_url, notice: 'Logged out'
  end

  private

  def loged_in?
    if current_author
      redirect_to root_url, notice: 'You are already loged in'
    end
  end
end
