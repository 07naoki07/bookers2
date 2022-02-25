class BooksController < ApplicationController
    before_action :correct_user, only: [:edit, :update]
    
  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end
  
  def create
    @book =Book.new(book_params)
    @book.user_id = current_user.id
    if@book.save
     flash[:notice] = "You have creatad book successfully."
     redirect_to book_path(@book.id)
    else
     @user = current_user
     @books=Book.all
     render:index
    end
  end
  
  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @book_new =Book.new
  end
  
  def edit
    @book =Book.find(params[:id])
    if @book.user == current_user
        render "edit"
    else
        redirect_to books_path
    end
  end
  
  def update
    @book = Book.find(params[:id])
   if @book.update(book_params)
     flash[:notice] = "successfully"
     redirect_to book_path(@book.id)  
   else
     render  'books/edit'
   end
  end
  
  def destroy
    book= Book.find(params[:id])
   if book.destroy
    flash[:notice] = "successfully" 
    redirect_to'/books'
   else
     @books=Book.all
     render:index
   end
  end  
  
  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end
end
