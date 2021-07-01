class BadgesController < ApplicationController
  def show
    @user = User.find(params[:user_id])
    
    color = '66ccff'
    status = 'Free'

    @user.calendars.each do |calendar|
      if calendar.covered?(DateTime.now)
        color = calendar.color[1..-1]
        status = calendar.display_as
        break
      end
    end

    resp = Faraday.get 'https://img.shields.io/static/v1', {
      label: 'Busy Status',
      message: status,
      color: color,
    }

    response.headers["Cache-Control"] = "no-cache, no-store"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Mon, 01 Jan 1990 00:00:00 GMT"
    send_data resp.body, :filename => 'status.svg', :type => 'image/svg+xml'
  end
end
