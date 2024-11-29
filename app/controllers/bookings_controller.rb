class BookingsController < ApplicationController
  def new
    @booking = Booking.new
    @booking.meal = Meal.find(params[:meal_id])
    @meal = Meal.find(params[:meal_id])
  end

  def create
    @booking = Booking.new(user: current_user, status: "confirmée")
    @booking.meal = Meal.find(params[:meal_id])
    if @booking.save
      redirect_to dashboard_path, notice: "Réservation confirmée !"
    else
      render :new, status: :unprocessable_entity
    end

    def invite
    end
  end

    #  A RAJOUTER le "":photos" dans la méthode plus tard
  # def booking_params
  #   params.require(:article).permit(:photos)
  # end
end
