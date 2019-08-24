class MessagesController < ApplicationController

  def create
    @message = Message.new(message_params)
    @ride = Ride.find(params[:ride_id])
    @message.ride = @ride
    @message.user = current_user
    if @message.save
      respond_to do |format|
        format.html { redirect_to ride_path(@ride) }
        format.js  # <-- will render `app/views/reviews/create.js.erb
      end
    else
      respond_to do |format|
        format.html { render 'rides/show' }
        format.js  # <-- idem
      end
    end
  end

  private
  def message_params
    params.require(:message).permit(:message)
  end
end
