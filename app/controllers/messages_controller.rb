class MessagesController < ApplicationController

  def create
    @message = Message.new(message_params)
    authorize @message
    @ride = Ride.find(params[:ride_id])
    @message.ride = @ride
    @message.user = current_user
    if @message.save
      redirect_to ride_path(@ride)
    else
      flash[:alert] = ""
      redirect_to ride_path(@ride)
    end

  end

  private
  def message_params
    params.require(:message).permit(:message)
  end
end
