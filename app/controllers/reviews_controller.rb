class ReviewsController < ApplicationController

  def create
    @review = Review.new
    authorize @review
    @ride = Ride.find(params[:ride_id])
    @review.ride = @ride
    @review.user = current_user
    if @review.save
      redirect_to ride_path(@ride)
    else
      flash[:alert] = "couldn't review"
      redirect_to ride_path(@ride)
    end
  end

end
