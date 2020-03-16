class RegistrationsController < ApplicationController
  before_action :check_active_session, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      @error = true
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

  def check_active_session
    redirect_to root_path if current_user.present?
  end
end
