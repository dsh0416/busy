class Calendar < ApplicationRecord
  belongs_to :user
  has_many :calendar_histories

  enum status: %i(enabled paused excluded)
end
