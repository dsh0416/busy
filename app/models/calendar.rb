class Calendar < ApplicationRecord
  belongs_to :user
  has_many :calendar_histories
  has_many :calendar_events

  enum status: %i(enabled paused excluded)

  def refresh_events
    ActiveRecord::Base.transaction do
      calendar_events.destroy_all
      ical = Icalendar::Calendar.parse(content)
      ical.each do |cal|
        cal.events.each do |event|
          started = event.dtstart
          ended = event.dtend
          next if started.nil? or ended.nil?
          next if started.to_datetime + 1.day <= ended.to_datetime # Filter all-day events
          CalendarEvent.create!(
            calendar: self,
            summary: event.summary,
            started_at: event.dtstart,
            ended_at: event.dtend,
          )
        end
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
