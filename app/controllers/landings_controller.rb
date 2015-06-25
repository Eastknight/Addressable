class LandingsController < ApplicationController
  def index
    redirect_to contacts_path if current_user
  end
end
