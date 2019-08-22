class UserridesController < ApplicationController

  def create
    @userride = Userride.new
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

end
