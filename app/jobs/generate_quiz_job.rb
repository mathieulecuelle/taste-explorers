class GenerateQuizJob < ApplicationJob
  queue_as :default

  def perform(meal_id)
    Rails.logger.info "Début de GenerateQuizJob pour le meal ID: #{meal_id}"
    meal = Meal.find(meal_id)

    if meal.dishes.empty?
      Rails.logger.warn "Aucun plat trouvé pour le meal ID: #{meal_id}. Le quiz ne peut pas être généré."
      return
    end

    meal.dishes.each do |dish|
      Rails.logger.info "Génération du quiz pour le plat: #{dish.name}"
      client = OpenAI::Client.new
      response = client.chat(
        parameters: {
          model: "gpt-3.5-turbo",
          messages: [
            {
              role: "user",
              content: <<~MESSAGE
                Génére un résumé de 3 lignes maximum mettant l'accent sur l'histoire et la culture du plat "#{dish.name}"; ensuite saute une ligne et génère un quiz rapide avec 3 questions/réponses liées au plat "#{dish.name}" qui inclut des aspects culturels et historiques. Chaque ligne doit contenir la question, puis un ";" suivi de 3 réponses possibles séparées par des ';', et ensuite la réponse correcte entre parenthèses.
              MESSAGE
            }
          ]
        }
      )

      if response && response["choices"] && response["choices"][0] && response["choices"][0]["message"] && response["choices"][0]["message"]["content"]
        questions_and_answers = response["choices"][0]["message"]["content"]
        Rails.logger.info "Contenu généré par OpenAI: #{questions_and_answers}"

        tab = questions_and_answers.split("\n")
        memo = tab.shift.strip
        dish.update!(memo: memo)

        tab.each do |qa|
          question_and_options, correct_answer = qa.split(" (")
          next unless question_and_options && correct_answer
          correct_answer = correct_answer.delete(")").strip
          parts = question_and_options.split("; ")
          question = parts[0].strip
          options = parts[1..].join("; ").chomp(";").strip

          Question.create!(
            question: question,
            options_answers: options,
            answer: correct_answer,
            dish_id: dish.id
          )
        end
      else
        Rails.logger.error "Réponse invalide de l'API OpenAI pour le plat '#{dish.name}'."
      end
    end
  rescue StandardError => e
    Rails.logger.error "Erreur dans GenerateQuizJob: #{e.message}"
    Rails.logger.error e.backtrace.join("\n")
  end
end
