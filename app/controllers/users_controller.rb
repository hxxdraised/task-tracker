class UsersController < ApplicationController
  before_action -> { authorize User }, only: %i[ show ]
  skip_after_action :verify_authorized, only: [:new, :create]

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(users_params)

    if @user.save
      redirect_to projects_path, notice: "You've successfully signed up!"
    else
      render :new
    end
  end

  private

  def users_params
    params.require(:user).permit(:full_name, :email, :password)
  end
end
