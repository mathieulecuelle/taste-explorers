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
                Génère un résumé de 3 lignes maximum mettant en avant l’histoire et la culture associées au plat #{dish.name}. Ensuite, saute une ligne via \n et crée un quiz rapide comprenant 3 questions avec leurs réponses liées à l’histoire et à la culture de ce plat. Chaque question doit être suivie d’un point-virgule « ; », de 3 réponses possibles séparées par des points-virgules « ; », et de la bonne réponse indiquée entre parenthèses à la fin.
                Voici un exemple de réponse que j’attends de ta part sur le plat ‘Steak frites’(respectes scrupuleusement ce format) : Le plat emblématique Steak frites est une combinaison savoureuse de viande de bœuf grillée et de pommes de terre frites, originaire de France. Il est étroitement lié à la culture culinaire française, symbolisant la simplicité et l'élégance de la cuisine française traditionnelle. Ce plat copieux et délicieux est souvent accompagné de sauces comme le béarnaise ou le poivre.\n1. Quel pays est à l'origine du plat Steak frites ; France ; Italie ; Espagne ; (France)\n2. Quels types de viande sont généralement utilisés pour préparer un Steak frites ; Bœuf ; Porc ; Poulet ; (Bœuf)\n3. Quelle est la sauce classique servie avec un Steak frites ; Béarnaise ; Ketchup ; Sauce barbecue ; (Béarnaise)
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
