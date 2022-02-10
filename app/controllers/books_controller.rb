class BooksController < ApplicationController
  before_action :correct_user, only: [:edit, :update]



  def create
    @book=Book.new(book_params)
    @book.user_id = current_user.id
    @books=Book.all
    @users=User.all
    @user = current_user
    if @book.save
      redirect_to book_path(@book)
      flash[:notice] ="You have created book successfully."
    else
      render :index
    end
  end

  def index
     to = Time.current.at_end_of_day
     from = (to - 6.day).at_beginning_of_day
      @books = Book.all.sort {|a,b|
      b.favorites.where(created_at: from...to).size <=>
      a.favorites.where(created_at: from...to).size
    }
    # @books= Book.includes(:favorited_users).
    # sort {|a,b|
    #   b.favorited_users.includes(:favorites).where(created_at: from...to).size <=>
    #   a.favorited_users.includes(:favorites).where(created_at: from...to).size
    # }
    @book=Book.new
    # @books=Book.all
    # @users=User.where(book_id:@book.id)
    # @users=User.find_by(id: @book.user_id)
    @users=User.all
    @user=current_user


  end


  def show
    @book=Book.find(params[:id])
    @user =User.find_by(id: @book.user_id)
    @book_comment=BookComment.new

  end

  def edit
     @book = Book.find(params[:id])
    # @books=Book.new
  end

  def update
    # @books=Book.new
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id)
       flash[:notice] ="You have updated book successfully."
    else
      render :edit
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

  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end
end
