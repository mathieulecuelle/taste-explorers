class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:choose_action]
  def home
  end

  def choose_action
    @users = User.all
  end
end
