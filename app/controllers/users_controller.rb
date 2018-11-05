class UsersController < ApplicationController
  def new
  end

  def create
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
    if (logged_in? && params[:id].to_i != session[:user_id].to_i)
      flash.now[:danger] = "you can not access to any other user but yourserlf"
      render 'show'
    elsif (!logged_in?)
      flash.now[:danger] = "you need to subscrib (or login)"
      render 'new'
    end
  end

  def index
    unless logged_in?
      flash.now[:danger] = "you need to subscrib (or login)"
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end

end
