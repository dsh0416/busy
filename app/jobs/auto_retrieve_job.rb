class AutoRetrieveJob < ApplicationJob
  queue_as :default

  def perform
    Calendar.where(status: :enabled).each do |calendar|
      history = CalendarHistory.create!(calendar: calendar, status: :pending, log: 'Fetching...')
      RetrieveIcsJob.perform_later(history)
    end
  end
end
