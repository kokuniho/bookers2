class UsersController < ApplicationController
   before_action :authenticate_user!
   before_action :ensure_guest_user, only: [:edit]
  # before_action :correct_user, only: [:edit]



  def show

    @user=User.find(params[:id])
    # @books=@user.books
    @books=Book.where(user_id:@user.id)
    # @user =User.find_by(id: @book.user_id)
    # @user=@books.user
  end

  def index
    @users=User.all
    @user=current_user
    @books=Book.all
  end

  def edit
    @user=User.find(params[:id])
    if @user == current_user
      render "edit"
    else
      redirect_to books_path
    end
  end
  #   if @user == current_user
  #   render "edit"
  # 　else
  #   redirect_to books_path
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def correct_user
    @user = User.find(params[:id])

     redirect_to(user_session_path(user_id)) unless @user == current_user
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end
end

# 　def update_resource(resource, params)
#     resource.update_without_password(params)
#   end




