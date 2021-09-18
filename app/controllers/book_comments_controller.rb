class BookCommentsController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    @book_comment = current_user.book_comments.new(book_comment_params)
    @book_comment.book_id = @book.id
    if @book_comment.save
    else
      @newbook = Book.new
      @user = @book.user
    end
  end

  def destroy
    @book = Book.find(params[:book_id])
    comment = BookComment.find_by(id: params[:id])
    comment.destroy
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
