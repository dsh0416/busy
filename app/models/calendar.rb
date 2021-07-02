class Calendar < ApplicationRecord
  belongs_to :user
  has_many :calendar_histories
  has_many :calendar_events

  enum status: %i(enabled paused excluded)

  def refresh_events
    calendar_events.destroy_all
    ical = Icalendar::Calendar.parse(content)
    ical.each do |cal|
      cal.events.each do |event|
        started = event.dtstart
        ended = event.dtend
        next if started.nil? or ended.nil?
        next if ended - started >= 1.day # Filter all-day events
        CalendarEvent.create!(
          calendar: self,
          started_at: event.dtstart,
          ended_at: event.dtend,
        )
      end
    end
  end

  def events_count
    calendar_events.count
  end

  def covered?(datetime)
    calendar_events.where('started_at <= ? AND ended_at >= ?', datetime, datetime).exists?
  end
end
