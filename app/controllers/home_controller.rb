class HomeController < ApplicationController
  def index
    redirect_to new_profile_path if current_user && !current_user.profile.present?
  end
end
