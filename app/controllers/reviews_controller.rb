class ReviewsController < ApplicationController
before_action :find_ride, only: [:new, :create]

  def new
    authorize @ride
    render 'reviews/_reviewform', ride: @ride, review: Review.new
  end

  def create
    @review = Review.new(review_params)
    raise
    authorize @review
    @review.beach = @ride.beach
    @review.user = current_user
    if @review.save
      redirect_to ride_path(@ride)
    else
      flash[:alert] = "couldn't review"
      redirect_to ride_path(@ride)
    end
  end

  private
  def review_params
    params.require(:review).permit(:rating, :description)
  end

  def find_ride
    @ride = Ride.find(params[:ride_id])
  end

end
