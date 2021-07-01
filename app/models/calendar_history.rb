class CalendarHistory < ApplicationRecord
  belongs_to :calendar

  enum status: %i(pending success failed)
end
