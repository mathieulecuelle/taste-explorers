class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :choose_action]
  def home
  end

  def choose_action
  end
end
