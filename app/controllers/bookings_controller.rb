class BookingsController < ApplicationController
  before_action :set_booking, except: [:new, :index, :create]
  def index
    @bookings = current_user.bookings
    @mydogs = current_user.dogs
  end

  def new
    @dog = Dog.find(params[:dog_id])
    @booking = @dog.bookings.new
  end

  def create
    @dog = Dog.find(params[:dog_id])
    @booking = @dog.bookings.new(booking_params)
    @booking.user = current_user
    @booking.status = "pending"
    if @booking.save
      redirect_to bookings_path, notice: "Booking created successfully."
    else
      render :new
    end
  end

  def edit

  end

  def update
    @dog = Dog.find(params[:dog_id])
    @booking = Booking.find(params[:id])
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
    if @booking.update(status: "accepted")
      redirect_to bookings_path, notice: "Booking accepted!"
    else
      redirect_to bookings_path, alert: "Failed to accept the booking."
    end
  end

  def reject
    if @booking.update(status: "rejected")
      redirect_to bookings_path, notice: "Booking rejected."
    else
      redirect_to bookings_path, alert: "Failed to reject the booking."
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
