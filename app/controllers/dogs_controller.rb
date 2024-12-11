class DogsController < ApplicationController
  def index
    @dogs = Dog.all
  end

  def show
    @dog = Dog.find(params[:id])
  end

  def new
    @dog = Dog.new
  end

  def create
    @dog = Dog.new(dog_params)
    @dog.save
    redirect_to dogs_path(@dog)
  end

  private

  def dog_params
    params.require(:dog).permit(:name, :age, :breed, :gender, :size, :temperament)
  end
end
