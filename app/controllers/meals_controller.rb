class MealsController < ApplicationController

  def index
    @meals = Meal.all
  end

  def proposals
    # On devra ici filtrer par allergie / préférence alimentaire
    @meals = Meal.last(3)
  end

  def show
    @meal = Meal.find(params[:id])
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
      redirect_to meal_path(@meal)
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
    params.require(:meal).permit(:title, :description, :duration, :location, :price_per_person, :maximum_guests, :date)
  end

end
