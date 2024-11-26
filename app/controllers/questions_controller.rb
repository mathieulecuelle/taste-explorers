class QuestionsController < ApplicationController
  def index
    # @meal = Meal.find(params[:meal_id]) # Find the associated meal
    # @questions = @meal.questions       # Assuming Meal has_many :questions
  end

  def create
    # @meal = Island.find(params[:id])
    raise
    @name = "Guacamole"

    Rails.cache.fetch("#{cache_key_with_version}/content") do
      client = OpenAI::Client.new
      chatgpt_response = client.chat(parameters: {
        model: "gpt-4o-mini",
        messages: [{ role: "user", content: "Generate a quick of 5 questions/answers related to #{name} culture and history"}]
      })
      raise
      @results = chatgpt_response["choices"][0]["message"]["content"]
    end



  end

end
