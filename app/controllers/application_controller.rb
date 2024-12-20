class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?


  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end

  protected

  # Permet à Devise de prendre en charge le champ `photo`
  def configure_permitted_parameters
    # Permet à Devise de gérer l'upload de la photo lors de l'inscription (sign_up)
    devise_parameter_sanitizer.permit(:sign_up, keys: [:photo, :first_name, :last_name])

    # Permet à Devise de gérer l'upload de la photo lors de la mise à jour du profil (account_update)
    devise_parameter_sanitizer.permit(:account_update, keys: [:photo])
  end
end
