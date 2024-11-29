module Users
  class PreferencesController < ApplicationController
    before_action :authenticate_user!

    def edit
      @user = User.find(params[:id])
      @preferences = @user.preferences
    end

    def update
      @user = User.find(params[:id])
      @preferences = @user.preferences

      if @preferences.update(preferences_params)
        redirect_to edit_preferences_user_path(@user), notice: 'Preferences updated'
      else
        render :edit
      end
    end

    private

    def preferences_params
      params.require(:user).permit(:reference_type, :name)
    end
  end
end
