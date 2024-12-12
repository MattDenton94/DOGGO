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
    @booking = Booking.find(params[:id])
  end

  def update
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove("booking_#{@booking.id}") }
      format.html { redirect_to bookings_path, notice: 'Booking was successfully deleted.' }
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
