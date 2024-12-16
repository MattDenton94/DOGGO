class ReviewsController < ApplicationController

  def index
    @dog = Dog.find(params[:dog_id])
    @reviews = @dog.reviews
  end

  def show
    @review = Review.find(params[:id])
    @dog = @review.booking.dog
    @booking = @review.booking
  end

  def create
    @dog = Dog.find(params[:dog_id])
    @review = Review.new(review_params)
    @review.dog = @dog
    if @review.dog
      redirect_to dogs_path(@dog), notice: "Review added successfully!"
    else
      render "dogs/show", status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(:comment, :rating)
  end
end
