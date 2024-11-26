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

    @booking.save
      redirect_to dashboard_path, notice: 'Votre réservation a été créée avec succès.'

  end

  def update
    @booking.update(booking_params)
      redirect_to dashboard_path, notice: 'La réservation a été mise à jour.'
  end

  def destroy
    @booking.user == current_user || @booking.meal.user == current_user
      @booking.destroy
      redirect_to dashboard_path, notice: 'La réservation a été annulée.'

  end

  private

  # Trouve le repas associé à la réservation
  def set_meal
    @meal = Meal.find(params[:meal_id])
  end

  # Trouve une réservation spécifique
  def set_booking
    @booking = Booking.find(params[:id])
  end

  # Filtre les paramètres autorisés pour une réservation
  def booking_params
    params.require(:booking).permit(:status)
  end





  def confirm
    @user_name = "Guillaume" # Exemple de donnée utilisateur
    @date = DateTime.new(2024, 8, 1, 20, 30) # Exemple de date
    @location = "Nantes"
    @reservation_price = 21
    @service_fee = 3
    @total_price = @reservation_price + @service_fee
  end

end
