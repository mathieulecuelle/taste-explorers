class DishesController < ApplicationController

  before_action :set_meal
  
  def new
    @meal = Meal.find(params[:meal_id])
    @dish = Dish.new
  end

  def create
    @dish = Dish.new(dish_params)
    @dish.meal = Meal.find(params[:meal_id])
    if @dish.save
      redirect_to new_meal_dish_path(@dish.meal)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_meal
    @meal = Meal.find(params[:meal_id])
  end

  def dish_params
    params.require(:dish).permit(:course_type, :name)
  end
end
