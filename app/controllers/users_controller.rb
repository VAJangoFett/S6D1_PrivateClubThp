class UsersController < ApplicationController
  def new
  end

  def create
    p params
    user = User.create(user_params)
    if user.id
      log_in(user)
      redirect_to user
    else
      flash.now[:danger] = "email already used"
      render 'new'
    end



  end

  def show
    if logged_in?
      @user = User.find(current_user[:id])
    else
      flash.now[:danger] = "you need to subscrib (or login)"
      render 'new'
    end
  end

  def index
    if logged_in?
      @users = User.all
    else
      flash.now[:danger] = "you need to subscrib (or login)"
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end

end
