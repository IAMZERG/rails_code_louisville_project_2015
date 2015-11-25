class PasswordResetsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user
      user.generate_password_reset_token!
      Notifier.password_reset(user).deliver
      flash.now[:notice] = "Huzzah! You may check your email for the password reset link."
      redirect_to new_user_session_path
    else
      flash.now[:notice] = "Email not found."
      render action: 'new'
    end
  end

  def edit
    @user = User.find_by(password_reset_token: params[:id])
    if @user
      response.status = 200
    else
      response.status = 404
      render file: 'public/404.html'
    end
  end

  def update
    @user = User.find_by(password_reset_token: params[:id])
    if @user && @user.update_attributes(user_params)
      flash.now[:notice] = "Password reset was successful."
      @user.update_attribute(:password_reset_token, nil)
      session[:user_id] = @user.id
      redirect_to decklists_path, notice: "Password reset was successful."
    else
      flash.now[:notice] = "Password reset token was not found."
      render action: 'edit'
    end
  end

  private
  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

end
