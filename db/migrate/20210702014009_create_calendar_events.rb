class CreateCalendarEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :calendar_events do |t|
      t.string :summary, null: false
      t.datetime :started_at, null: false
      t.datetime :ended_at, null: false

      t.belongs_to :calendar, null: false
      t.timestamps
    end
  end
end
