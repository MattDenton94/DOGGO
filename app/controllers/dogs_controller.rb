class DogsController < ApplicationController
  def index
    @dogs = Dog.all
  end

  def show
    @dog = Dog.find(params[:id])
  end

  def new
    @dog = Dog.new(user_id: current_user.id)
  end

   def create
    @dog = current_user.dogs.new(dog_params)
    if @dog.save
      redirect_to @dog, notice: "Dog added successfully."
    else
      render :new
    end
  end

  private

  def dog_params
    params.require(:dog).permit(:name, :age, :breed, :gender, :size, :temperament)
  end
end
