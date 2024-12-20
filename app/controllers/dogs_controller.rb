class DogsController < ApplicationController
  def index
    # Check if there's a search query in the params
    if params[:query].present?
      # Use the pg_search_scope to search dogs by name and breed
      @dogs = Dog.search_by_name_and_breed(params[:query])
    else
      # If no search query, show all dogs
      @dogs = Dog.all
    end
  end

  def show
    @dog = Dog.find(params[:id])
    @booking = current_user.bookings.find_by(dog: @dog)
  end

  def new
    @dog = Dog.new(user_id: current_user.id)
  end

  def edit
    @dog = Dog.find(params[:id])
  end

  def update
    @dog = Dog.find(params[:id])
    if @dog.update(dog_params)
      redirect_to @dog, notice: "Dog updated successfully."
    else
      render :edit
    end
  end

   def create
    @dog = current_user.dogs.new(dog_params)
    if @dog.save
      redirect_to @dog, notice: "Dog added successfully."
    else
      render :new
    end
  end

  def destroy
    @dog = Dog.find(params[:id])
    if @dog.user == current_user
      @dog.destroy
      redirect_to dogs_path, notice: "Dog deleted successfully."
    else
      redirect_to dogs_path, alert: "You can only delete your own dogs."
    end
  end

  private

  def dog_params
    params.require(:dog).permit(:name, :age, :breed, :gender, :size, :temperament, :photo, :user_id, :street, :city)
  end
end
