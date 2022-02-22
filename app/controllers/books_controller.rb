class BooksController < ApplicationController
  def index
    @book = Book.new
    @books = Book.all
  end
  
  def create
    @book =Book.new(book_params)
    @book.user_id = current_user.id
    if@book.save
     redirect_to books_path(@book.id)
    else
     @books=Book.all
     render:index
    end
  end
  
  def show
    @book = Book.find(params[:id])
  end
  
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end
  
  
  private

  def book_params
    params.require(:book).permit(:shop_name, :caption)
  end
end