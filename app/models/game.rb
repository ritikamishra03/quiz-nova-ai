class Game < ApplicationRecord
  belongs_to :user

  CATEGORIES = ["Science", "History", "Geography", "Sports", "Movies & TV", "Technology"].freeze

  SUBCATEGORIES = {
    "Science"     => ["Physics", "Chemistry", "Biology", "Space & Astronomy", "Earth Science", "Inventions & Discoveries"],
    "History"     => ["Ancient History", "Medieval History", "World Wars", "American History", "Asian History", "African History"],
    "Geography"   => ["World Capitals", "Countries & Flags", "Mountains & Rivers", "Oceans & Seas", "US Geography", "European Geography"],
    "Sports"      => ["Football (Soccer)", "Cricket", "Basketball", "Tennis", "Olympics", "Formula 1"],
    "Movies & TV" => ["Hollywood", "Bollywood", "Tollywood", "K-Drama & Cinema", "Anime & J-Cinema", "British Cinema"],
    "Technology"  => ["Programming & Coding", "AI & Machine Learning", "Gaming", "Social Media", "Gadgets & Hardware", "Cybersecurity"]
  }.freeze

  validates :category, presence: true

  def finished?
    total_questions >= question_limit
  end

  def record_answer(correct:)
    points = correct ? 10 : 0
    increment!(:total_questions)
    increment!(:score, points) if correct
    points
  end
end
