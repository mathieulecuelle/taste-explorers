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
      redirect_to meal_booking_confirmation_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def confirmation
  end

  def validate
    redirect_to dashboard_path, notice: "Réservation confirmée !"
  end

  def invite
    # Le contenu de l'email qui sera utilisé comme modèle
    @email = {
      objet: "Vous avez été invité",
      contenu: "On vous a invité à un dîner sur Taste Explorer"
    }
    if params[:email]
      # TODO : envoyer un email à params[:email]
    end
  end

    #  A RAJOUTER le "":photos" dans la méthode plus tard
  # def booking_params
  #   params.require(:article).permit(:photos)
  # end
end
