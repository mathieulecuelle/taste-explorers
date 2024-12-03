class MealsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    @meals = Meal.all
    if params[:search].present?
      address = params[:search][:address]
      start_date = params[:search][:start_date]
      end_date = params[:search][:end_date]

      # Géocodage de l'adresse pour obtenir les coordonnées
      location = Geocoder.coordinates(address)

      if location
        latitude, longitude = location
        # Filtrer les meals dans un rayon de 5 km et dans la plage de dates
        @meals = @meals.near([latitude, longitude], 5).where(date: start_date..end_date)
      else
        @meals = @meals.where(date: start_date..end_date)
      end
    end
  end

  def proposals
    @meals = Meal.all
    if params[:search].present?
      address = params[:search][:address]
      start_date = params[:search][:start_date]
      end_date = params[:search][:end_date]

      # Géocodage de l'adresse pour obtenir les coordonnées
      location = Geocoder.coordinates(address)

      if location
        latitude, longitude = location
        # Filtrer les meals dans un rayon de 5 km
        @meals = @meals.near([latitude, longitude], 5)
      end

      # Appliquer les filtres de date uniquement si les dates sont présentes
      if start_date.present? && end_date.present?
        @meals = @meals.where(date: start_date..end_date)
      elsif start_date.present?
        @meals = @meals.where('date >= ?', start_date)
      elsif end_date.present?
        @meals = @meals.where('date <= ?', end_date)
      end
    end
    @meals = @meals.order(date: :asc)
  end


  def show
    @meal = Meal.find(params[:id])
    @marker = {
      lat: @meal.gps_latitude,
      lng: @meal.gps_longitude
    }
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
