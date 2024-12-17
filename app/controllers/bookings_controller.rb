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
    if @booking.update(booking_params)
      redirect_to dog_bookings_path(@dog), notice: "Booking updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove("booking_#{@booking.id}") }
      format.html { redirect_to bookings_path, notice: 'Booking was successfully deleted.' }
    end
  end

  def accept
    # Use ActiveRecord's `update` method to change the booking status to 'accepted'
    if @booking.update(status: "accepted")
      redirect_to @booking, notice: "Booking accepted!"
    else
      redirect_to @booking, alert: "Failed to accept the booking."
    end
  end

  def reject
    if @booking.update(status: "rejected")
      redirect_to @booking, notice: "Booking rejected."
    else
      redirect_to @booking, alert: "Failed to reject the booking."
    end
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
