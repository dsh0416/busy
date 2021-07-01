class Bootstrap < ActiveRecord::Migration[6.1]
  def change
    create_table(:users) do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at
      
      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      t.timestamps null: false

      t.index :email,                unique: true
      t.index :reset_password_token, unique: true
    end

    create_table(:calendars) do |t|
      t.string   :display_as, null: false
      t.string   :url
      t.integer  :status, default: 0
      t.string   :content, comment: 'iCalendar Raw Content'
      t.string   :color, null: false

      t.timestamps null: false

      t.belongs_to :user, null: false

      t.index [:user_id, :url], unique: true
    end

    create_table(:calendar_histories) do |t|
      t.integer :status, default: 0
      t.string  :log, null: false
      t.timestamps null: false

      t.belongs_to :calendar, null: false
    end
  end
end
