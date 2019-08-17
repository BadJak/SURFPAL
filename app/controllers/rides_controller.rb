class RidesController < ApplicationController

  skip_before_action :authenticate_user!, only: [:index, :show]

  def index

    Beach.joins(:rides)

    @rides = Ride.all
    if params[:where].present? && params[:when].present? && params[:experience].present?

          @rides = Ride.joins(:beach).where(beach:{city: params[:where]},
            date: params[:when])
    else
          redirect_to root_path
    end
  end

  def show
    @ride = Ride.find(params[:id])
  end
end
