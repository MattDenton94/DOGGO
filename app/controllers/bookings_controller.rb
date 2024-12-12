class BookingsController < ApplicationController
  def index
    @bookings = current_user.bookings
  end

  def new
    @dog = Dog.find(params[:dog_id])
    @booking = @dog.bookings.new
  end

  def create
    @dog = Dog.find(params[:dog_id])
    @booking = @dog.bookings.new(booking_params)
    @booking.user = current_user
    if @booking.save
      redirect_to bookings_path, notice: "Booking created successfully."
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
