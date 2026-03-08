class AddLanguageToGames < ActiveRecord::Migration[8.1]
  def change
    add_column :games, :language, :string, default: "English", null: false
  end
end
