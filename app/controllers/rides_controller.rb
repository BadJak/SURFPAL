class RidesController < ApplicationController

  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @rides = Ride.all
    if params[:Where].present?
          @rides = Ride.where(city: params[:where])
    else
          @rides = Ride.all
    end
  end

  def show
    @ride = Ride.find(params[:id])
  end
end
