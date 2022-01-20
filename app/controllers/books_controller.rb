class BooksController < ApplicationController

  def new
    @book=Book.new
  end

  def create
    @book=Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to books_path
  end

  def index
    @book=Book.new
    @books=Book.all
    @user = current_user
  end

  def ensure_correct_user
    @book = Book.find_by(id:params[:id])
    if @book.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/books/index")
    end
  end

  def show
  end

  def edit
  end

  def book_params
    params.require(:book).permit(:title, :body, :image)
  end
end