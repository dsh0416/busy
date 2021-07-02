class BadgesController < ApplicationController
  def show
    @user = User.find(params[:user_id])
    
    color = '66ccff'
    status = 'I’m free. Call me maybe.'

    @user.calendars.where(status: %i(enabled paused)).each do |calendar|
      if calendar.covered?(DateTime.now)
        color = calendar.color[1..-1]
        status = calendar.display_as
        break
      end
    end

    response.headers["Cache-Control"] = "no-cache, no-store"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Mon, 01 Jan 1990 00:00:00 GMT"

    query = {
      label: 'Busy Status',
      message: status,
      color: color,
      style: params[:style] || 'for-the-badge',
    }.to_query
    redirect_to "https://img.shields.io/static/v1?#{query}" 
  end
end
