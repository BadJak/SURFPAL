class UsersController < ApplicationController
before_action :find_user, only: [:show, :edit, :update, :destroy]

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :age, :level, :photo, :hometown, :bio)
  end

  def find_user
    @user = User.find(params[:id])
    authorize @user
  end
end
