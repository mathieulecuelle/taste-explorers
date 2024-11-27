class QuestionsController < ApplicationController
  before_action :set_meal

  def create
    @meal.dishes.each do |dish|
      client = OpenAI::Client.new
      response = client.chat(
        parameters: {
          model: "gpt-4",
          messages: [
            {
              role: "user",
              content: <<~MESSAGE
                Générer un quiz rapide avec 5 questions/réponses liées au plat "#{dish.name}" qui inclut des aspects culturels et historiques. Chaque ligne doit contenir la question, puis un ";" suivi de 3 réponses possibles séparées par des ';', et ensuite la réponse correcte entre parenthèses.
              MESSAGE
            }
          ]
        }
      )
      # Example of response OpenAI :::
      # "What is traditionally included in the French dish \"Salade de tomates\", and where does the dish originate from?; French fries and America; Fresh tomatoes and Belgium; Fresh tomatoes and France; (Fresh tomatoes and France)"
      questions_and_answers = response["choices"][0]["message"]["content"]
      questions_and_answers.split("\n").each do |qa|
        question_and_options, correct_answer = qa.split(" (")
        correct_answer = correct_answer.delete(")").strip if correct_answer

        parts = question_and_options.split("; ")
        question = parts[0].strip
        options = parts[1..].join("; ").chomp(";").strip

        q = Question.create!(
          question: question,
          options_answers: options,
          answer: correct_answer,
          dish_id: dish.id
        )
      end
    end
    redirect_to meal_path(@meal), notice: "Quiz généré avec succès!"
  end

  private

  def set_meal
    @meal = Meal.find(params[:meal_id])
  end
end
