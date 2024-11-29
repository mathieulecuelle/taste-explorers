# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # Méthode de mise à jour
  def update
    # Si l'utilisateur tente de modifier son mot de passe, nous utilisons update_with_password
    if params[:user][:password].present? || params[:user][:password_confirmation].present?
      if resource.update_with_password(user_params)
        handle_preferences_update
        redirect_to root_path, notice: "Profil mis à jour avec succès."
      else
        render :edit
      end
    else
      if resource.update(user_params)
        handle_preferences_update
        redirect_to root_path, notice: "Profil mis à jour avec succès."
      else
        render :edit
      end
    end
  end

  private

  # Méthode pour mettre à jour les préférences
  def handle_preferences_update
    if params[:user][:preferences].present?
      resource.preferences.each do |preference|
        preference.update(preference_type: params[:user][:preference_type], name: params[:user][:preferences][:name])
      end
    end
  end

  # Strong parameters
  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation, preferences: [:name])
  end


  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
