class QuestionsController < ApplicationController
  before_action :set_meal

  def create
    @meal.dishes.each do |dish|
      client = OpenAI::Client.new
      chatgpt_response = client.chat(
        parameters: {
          model: "gpt-4",
          messages: [
            {
              role: "user",
              content: "Generate a quick quiz with 5 questions/answers related to the dish: #{dish.name} that includes cultural and historical aspects. Each line should contain the question and related answer separated by :"
            }
          ]
        }
      )

      @questions_and_answers = chatgpt_response["choices"][0]["message"]["content"]
      @questions_and_answers.split("\n").each do |qa|
        # Créez des objets Question associés au plat
        # Ici, nous supposons que chaque "qa" est une ligne séparée avec une question et une réponse
        question, answer = qa.split(": ")
        @meal.questions.create(question: question, answer: answer) if question && answer
      end
    end

    redirect_to meal_path(@meal), notice: "Questions generated successfully!"
  end

  private

  def set_meal
    @meal = Meal.find(params[:meal_id])
  end
end
