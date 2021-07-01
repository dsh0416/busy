class Calendar < ApplicationRecord
  belongs_to :user
  has_many :calendar_histories

  enum status: %i(enabled paused excluded)

  def event_count
    return 0 if content.blank?
    ical = Icalendar::Calendar.parse(content)
    ical.map do |cal|
      cal.events.length
    end.sum
  rescue
    0
  end

  def covered?(datetime)
    return false if content.blank?
    ical = Icalendar::Calendar.parse(content)
    ical.map do |cal|
      cal.events.map do |event|
        started = event.dtstart
        ended = event.dtend
        next false if started.nil? or ended.nil?
        datetime >= started and datetime <= ended
      end.reduce(false, :|)
    end.reduce(false, :|)
  rescue
    false
  end
end
