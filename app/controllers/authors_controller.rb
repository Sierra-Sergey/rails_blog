class AuthorsController < ApplicationController
  before_action :set_author, only: %i[ show edit update destroy ]
  before_action :access_denied, only: %i[ destroy edit update ]

  def new
    @author = Author.new
  end

  def show
  end

  def edit
  end

  def create
    @author = Author.new(author_params)
    if @author.save
      session[:author_id] = @author_id
      redirect_to root_url, notice: 'Thank you for signing up'
    else
      render 'new'
    end
  end

  def destroy
  end

  def update
    respond_to do |format|
      if @author.update(author_params)
        format.html { redirect_to @author, notice: "Changes accepted" }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  private

  def author_params
    params.require(:author).permit(:email, :password, :password_confirmation, :first_name, :last_name, :gender, :birthday, :avatar)
  end

  def set_author
    @author = Author.find(params[:id])
  end

  def access_denied
    redirect_to @author, alert: 'Access denied' unless current_author == @author
  end
end
