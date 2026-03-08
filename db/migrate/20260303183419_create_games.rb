class CreateGames < ActiveRecord::Migration[8.1]
  def change
    create_table :games do |t|
      t.references :user, null: false, foreign_key: true
      t.string  :category,        null: false
      t.integer :score,           default: 0, null: false
      t.integer :total_questions, default: 0, null: false

      t.timestamps
    end
  end
end
