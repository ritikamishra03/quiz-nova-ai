class AddSettingsToGames < ActiveRecord::Migration[8.1]
  def change
    add_column :games, :question_limit, :integer, default: 10, null: false
    add_column :games, :time_limit, :integer  # seconds per question; null = no limit
  end
end
