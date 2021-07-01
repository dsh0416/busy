class CalendarHistory < ApplicationRecord
  belongs_to :calendar

  enum status: %i(success failed)
end
