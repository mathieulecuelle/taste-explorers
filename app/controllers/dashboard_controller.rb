class DashboardController < ApplicationController
  before_action :set_meal, except: [:show, :index]

  def index
    @section = params[:section] || 'reservations'
    if @section == 'organiser'
      @meals = current_user.meals
      @meals_pasts = current_user.meals.where("date < ?", Date.today)
    else  # @section == 'reservations'
      @bookings = current_user.bookings
      @bookings_pasts = current_user.bookings.joins(:meal).where('meals.date < ?', Date.today)
    end
  end

  def show
    @section = params[:section] || 'organiser'
    if @section == 'organiser'
      @meal = Meal.find(params[:id])
      @booking = Booking.new
    else  # @section == 'reservations'
      @booking = Booking.find(params[:id])
      @meal = @booking.meal
    end
    @bookings = @meal.bookings       # Récupérer toutes les réservations associées à ce repas
    @participants = @bookings.map(&:user)  # Récupérer tous les utilisateurs associés aux réservation
    @marker = {
      lat: @meal.gps_latitude,
      lng: @meal.gps_longitude
    }
  end

  def view_quiz
    @dish_index = params[:dish_id].to_i || 0  # Index du plat actuel
    @dish = @meal.dishes[@dish_index]  # Récupère le plat actuel
    @questions = @dish.questions  # Récupère les questions du plat
  end

  def generate_quiz
    @meal.dishes.each do |dish|
      client = OpenAI::Client.new
      response = client.chat(
        parameters: {
          model: "gpt-3.5-turbo",
          messages: [
            {
              role: "user",
              content: <<~MESSAGE
                Génére un résumé de 3 lignes maximum mettant l'accent sur l'histoire et la culture du plat "#{dish.name}"; ensuite saute une ligne et génère un quiz rapide avec 3 questions/réponses liées au plat "#{dish.name}" qui inclut des aspects culturels et historiques. Chaque ligne doit contenir la question, puis un ";" suivi de 3 réponses possibles séparées par des ";", et ensuite la réponse correcte entre parenthèses. Ni les réponses possibles, ni la bonne réponse ne doivent commencer par une séquence; donc par exemple ne pas mettre de "1" ou "1." ou "1)". Enfin ne rajoute pas de caractères spéciaux devant la question.
              MESSAGE
            }
          ]
        }
      )

      questions_and_answers = response["choices"][0]["message"]["content"]

      # Split the response into lines
      tab = questions_and_answers.split("\n")

      # The first line is the memo
      memo = tab.shift.strip
      dish.update!(memo: memo)

      # Create questions and answers from the remaining lines
      tab.each do |qa|
        question_and_options, correct_answer = qa.split(" (")
        next unless question_and_options && correct_answer # Skip invalid lines

        correct_answer = correct_answer.delete(")").strip
        correct_answer = correct_answer.delete(".")
        parts = question_and_options.split("; ")
        question = parts[0].strip
        options = parts[1..].join("; ").chomp(";").strip

        # Create the question for the dish
        Question.create!(
          question: question,
          options_answers: options,
          answer: correct_answer,
          dish_id: dish.id
        )
      end

    end

      # GenerateQuizJob.perform_later(@meal.id)

    redirect_to view_quiz_path(@meal.id), notice: "Quiz généré avec succès!"
  end

  private

  def set_meal
    @meal = Meal.find(params[:meal_id])
  end

end
