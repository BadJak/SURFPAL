class RidesController < ApplicationController

  skip_before_action :authenticate_user!, only: [:index, :show]

  def index

    Beach.joins(:rides)



    @rides = Ride.all
    if params[:where].present? && params[:when].present? && params[:experience].present?

          @rides = Ride.near(params[:where], 50)

          # @beaches = Ride.joins(:beach) #returns beaches with coordinates

             @markers = @rides.map do |ride|
               {
                 lat: ride.latitude,
                 lng: ride.longitude
               }
             end


    else
          redirect_to root_path
    end
  end

  def show
    @ride = Ride.find(params[:id])
  end
end
