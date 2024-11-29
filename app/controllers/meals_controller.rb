class MealsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    if params[:search].present?
      address = params[:search][:address]
      start_date = params[:search][:start_date]
      end_date = params[:search][:end_date]

      # Géocodage de l'adresse pour obtenir les coordonnées
      location = Geocoder.coordinates(address)

      if location
        latitude, longitude = location
        # Filtrer les meals dans un rayon de 5 km et dans la plage de dates
        @meals = Meal.near([latitude, longitude], 5)
                     .where(date: start_date..end_date)
      else
        # Si l'adresse n'est pas valide, retourner aucun meal ou tous les meals
        @meals = Meal.none
        flash[:alert] = "Adresse invalide. Veuillez réessayer."
      end
    else
      # Si aucun paramètre de recherche n'est fourni, afficher tous les meals
      @meals = Meal.all
    end
  end

  def proposals
    # On devra ici filtrer par allergie / préférence alimentaire
    @meals = Meal.last(3)
  end

  def show
    @meal = Meal.find(params[:id])
    @marker = {
      lat: @meal.gps_latitude,
      lng: @meal.gps_longitude
    }
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

  def new
    @meal = Meal.new
  end

  def create
    @meal = Meal.new(meal_params)
    @meal.user = current_user

    if @meal.save
      redirect_to new_meal_dish_path(@meal)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @meal = Meal.find(params[:id])
  end

  def update
    @meal = Meal.find(params[:id])
    @meal.update(meal_params)

    redirect_to meal_path(@meal)
  end

  def destroy
    @meal = Meal.find(params[:id])
    @meal.destroy

    redirect_to meals_path, status: :see_other
  end

  private

  def meal_params
    params.require(:meal).permit(:title, :description, :inspiration, :date, :heure, :location, :duration, :price_per_person, :maximum_guests, :photo)
  end

end
