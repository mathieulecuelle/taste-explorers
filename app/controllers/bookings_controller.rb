class BookingsController < ApplicationController
  def new
    @booking = Booking.new
    @booking.meal = Meal.find(params[:meal_id])
    @meal = Meal.find(params[:meal_id])
  end

  def create
    @booking = Booking.new(user: current_user, status: "accepted")
    @booking.meal = Meal.find(params[:meal_id])
    if @booking.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end
  
    #  A RAJOUTER le "":photos" dans la méthode plus tard
  # def booking_params
  #   params.require(:article).permit(:photos)
  # end
end
