# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :check_active_session, only: %i[new create]

  def new; end

  def create
    @user = User.find_by(email: params[:email])

    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to root_path
    else
      @error = true
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def check_active_session
    redirect_to root_path if current_user.present?
  end
end
