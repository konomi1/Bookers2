class BooksController < ApplicationController

  def index
    if params[:sort_latest]
      @books = Book.latest
    elsif params[:sort_favoritest]
      @books = Book.favoritest
    elsif params[:sort_rate_high]
      @books = Book.rate_high
    else
      @books = Book.all
    end
    @newbook = Book.new
    @user = current_user
  end

  def create
    @newbook = Book.new(book_params)
    @newbook.user_id = current_user.id
    if @newbook.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@newbook)
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def show
    @newbook = Book.new
    @book = Book.find(params[:id])
    @book_comment = BookComment.new
    impressionist(@book, nil, unique: [:ip_address])
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user.id != current_user.id
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book)
    else
      render :edit
    end

  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def search
    @records = Book.search_books(params[:word])
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :rate, :category)
  end

end
