class RidesController < ApplicationController

  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @rides = Ride.all
  end

  def show
    @ride = Ride.find(params[:id])
  end
end
