class UsersController < ApplicationController
  def index
    @users = User.all
    @newbook = Book.new
  end

  def create
    @newbook = Book.new(book_params)
    @newbook.user_id = current_user.id
    @newbook.save
    redirect_to books_path
  end

  def show
    @newbook = Book.new
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  private


  def book_params
    params.require(:book).permit(:title, :body,)
  end

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
