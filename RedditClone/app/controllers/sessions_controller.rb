class SessionsController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(user_params[:username], user_params[:password])

    if @user
      login!(@user)
      redirect_to users_url
    else
      flash.now[:errors] = ["Invalid username or passwordd"]
      render :new
    end
  end

  def destroy
    logout! if logged_in?
    redirect_to new_session_url
  end
end
