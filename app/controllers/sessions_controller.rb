class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:success] = "Signed in with #{@user.email}"
      redirect_to root_path
    else
      flash.now[:error] = 'Invalid email or password'
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    @current_user = nil
    flash[:success] = 'Logged out'
    redirect_to root_path
  end
end