class RetrieveIcsJob < ApplicationJob
  queue_as :default

  def perform(calendar_history)
    calendar = calendar_history.calendar
    response = Faraday.get calendar.url
    raise response.status unless response.status == 200
    calendar.content = response.body.force_encoding("UTF-8")
    calendar.save!

    calendar_history.status = :success
    calendar_history.log = 'success'
    calendar_history.save!
  rescue Exception => e
    calendar_history.status = :failed
    calendar_history.log = e.inspect
    calendar_history.save!
  end
end
