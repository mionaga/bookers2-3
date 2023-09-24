class BooksController < ApplicationController
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id

     if @book.save
       flash[:notice] ="You have saved book successfully"
       redirect_to book_path(@book.id)
     else
    
       @books= Book.all
       @user=current_user
       render :index
     end
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
    @book=Book.new

  end

  def update
    @book=Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] ="You have saved book successfully"
      redirect_to book_path(@book.id)
    else
       flash.now[:notice]="errors prohibited this obj from being saved:"
       render :edit
    end
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
