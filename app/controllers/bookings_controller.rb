class BookingsController < ApplicationController
  before_action :authenticate_user! # Assure que l'utilisateur est connecté
  before_action :set_meal, only: [:new, :create]
  before_action :set_booking, only: [:show, :update, :destroy]


  def index
    if current_user.host?
      @bookings = Booking.joins(:meal).where(meals: { user_id: current_user.id })
    else
      @bookings = current_user.bookings
    end
  end

  def show
    # @booking est défini dans le before_action
  end

  def new
    @booking = @meal.bookings.build
  end

  def create
    @booking = @meal.bookings.build(user: current_user, status: "accepted")

    if @booking.save
      redirect_to dashboard_path, notice: 'Votre réservation a été créée avec succès.'
    else
      flash.now[:alert] = 'Erreur lors de la création de la réservation.'
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @booking.update(booking_params)
      redirect_to dashboard_path, notice: 'La réservation a été mise à jour.'
    else
      flash.now[:alert] = 'Erreur lors de la mise à jour de la réservation.'
      render :show, status: :unprocessable_entity
    end
  end

  def destroy
    if @booking.user == current_user || @booking.meal.user == current_user
      @booking.destroy
      redirect_to dashboard_path, notice: 'La réservation a été annulée.'
    else
      redirect_to dashboard_path, alert: 'Vous n\'avez pas la permission d\'annuler cette réservation.'
    end
  end

  private

  # Trouve le repas associé à la réservation
  def set_meal
    @meal = Meal.find(params[:meal_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to meals_path, alert: 'Repas introuvable.'
  end

  # Trouve une réservation spécifique
  def set_booking
    @booking = Booking.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to dashboard_path, alert: 'Réservation introuvable.'
  end

  # Filtre les paramètres autorisés pour une réservation
  def booking_params
    params.require(:booking).permit(:status)
  end
end
