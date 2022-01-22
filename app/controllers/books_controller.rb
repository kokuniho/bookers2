class BooksController < ApplicationController

  def new
    @book=Book.new
  end

  def create
    @book=Book.new(book_params)
    @book.user_id = current_user.id
    @user = current_user
    if @book.save
      redirect_to book_path(@book)
      flash[:notice] ="You have created book successfully."
    else
      render :index
    end
  end

  def index
    @book=Book
    @books=Book.all
    @user = current_user
  end


  def show
    @book=Book.find(params[:id])
    @user =User.find_by(id: @book.user_id)
  end

  def edit
     @book = Book.find(params[:id])
  end

  def update
    book = Book.find(params[:id])
    if book.update(book_params)
       redirect_to book_path(book.id)
       flash[:notice] ="You have updated book successfully."
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def book_params
    params.require(:book).permit(:title, :body, :image)
  end
end
