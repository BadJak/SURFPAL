class UserridesController < ApplicationController

  def create
    @userride = Userride.new
    authorize @userride
    @ride = Ride.find(params[:ride_id])
    @userride.ride = @ride
    @userride.user = current_user
    if @userride.save
      redirect_to ride_path(@ride)
    else
      flash[:alert] = "You have already joined this ride"
      redirect_to ride_path(@ride)
    end
  end

  def destroy

    @ride = Ride.find(params[:id])
    @userride = Userride.where(ride_id: @ride.id, user_id: current_user.id).first
    authorize @userride
    if @userride.destroy
      redirect_to ride_path(@ride)
      flash[:alert] = "You have left this ride"
    else
      redirect_to ride_path(@ride)
      flash[:alert] = "Something went wrong. Please try again"
    end

  end

  private
  def userride_params
    params.require(:userride).permit(:ride_id, :user_id)
  end

end
