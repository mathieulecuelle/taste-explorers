class DashboardController < ApplicationController
  before_action :set_meal, except: [:show]

  def show
    @section = params[:section] || 'organiser'
    if @section == 'organiser'
      @meals = current_user.meals
      @meals_pasts = current_user.meals.where("date < ?", Date.today)
    else  # @section == 'reservations'
      @bookings = current_user.bookings
      @bookings_pasts = current_user.bookings.joins(:meal).where('meals.date < ?', Date.today)
    end
  end

  def view_quiz
    @dish_index = params[:dish_id].to_i || 0  # Index du plat actuel
    @dish = @meal.dishes[@dish_index]  # Récupère le plat actuel
    @questions = @dish.questions  # Récupère les questions du plat
  end

  def generate_quiz
    GenerateQuizJob.perform_later(@meal.id)

    redirect_to view_quiz_path(@meal.id), notice: "Quiz généré avec succès!"
  end

  private

  def set_meal
    @meal = Meal.find(params[:meal_id])
  end

end
