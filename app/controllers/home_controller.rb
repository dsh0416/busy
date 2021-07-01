class HomeController < ApplicationController
  def index
    if user_signed_in?
      redirect_to '/calendars'
    else
      redirect_to '/users/sign_in'
    end
  end
end
