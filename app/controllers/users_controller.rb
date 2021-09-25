class UsersController < ApplicationController

  before_action :ensure_current_user, only: [:edit, :update]


  def index
    @users = User.all
    @newbook = Book.new
    @user = current_user
  end

  def create
    @newbook = Book.new(book_params)
    @newbook.user_id = current_user.id
    @newbook.save
    redirect_to books_path
  end

  def show
    @user=User.find(params[:id])
    @books = @user.books
    date = params[:created_at]
    @records = @books.where("created_at LIKE?", date+"%" )
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private


  def book_params
    params.require(:book).permit(:title, :body,)
  end

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def ensure_current_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

end
