class BooksController < ApplicationController
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
     if @book.save
    redirect_to book_path(@book.id)
     else
       @books= Book.all
       render :index
     end
     @user = User.find(@book.user_id)
  end

  def show
    @book_new=Book.new
    @book=Book.find(params[:id])
    @user=User.find(@book.user_id)

  end

  def edit
    @book=Book.find(params[:id])
  end

  def index
    @books=Book.all
    @user=current_user
    @book_new=Book.new

  end

  def update
    @book=Book.find(params[:id])
    @book.update(book_params)
    redirect_to book_path(@book.id)
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end


  private

  def book_params
    params.require(:book).permit(:title, :body)
  end


end
