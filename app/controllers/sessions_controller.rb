class SessionsController < ApplicationController
  skip_after_action :verify_authorized

  def new
    @user = User.new
  end

  def create
    authenticated_user = User.find_by(
      email: user_params[:email]
    )&.authenticate(user_params[:password])

    if authenticated_user
      session[:current_user_id] = authenticated_user.id
      redirect_to projects_path, notice: "You've successfully logged in!"
    else
      @user = User.new
      @user.errors.add :base, "Wrong email or password"
      render :new
    end
  end

  def destroy
    session.delete(:current_user_id)

    redirect_to projects_path, notice: "You've successfully logged out!"
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
