module ApplicationHelper
  ICONS = {
    "Science"=>"🔬","History"=>"📜","Geography"=>"🌍","Sports"=>"⚽","Movies & TV"=>"🎬","Technology"=>"💻",
    "Physics"=>"⚛️","Chemistry"=>"🧪","Biology"=>"🧬","Space & Astronomy"=>"🔭","Earth Science"=>"🌋","Inventions & Discoveries"=>"💡",
    "Ancient History"=>"🏛️","Medieval History"=>"⚔️","World Wars"=>"🪖","American History"=>"🗽","Asian History"=>"🏯","African History"=>"🌍",
    "World Capitals"=>"🏙️","Countries & Flags"=>"🚩","Mountains & Rivers"=>"⛰️","Oceans & Seas"=>"🌊","US Geography"=>"🗺️","European Geography"=>"🏰",
    "Football (Soccer)"=>"⚽","Cricket"=>"🏏","Basketball"=>"🏀","Tennis"=>"🎾","Olympics"=>"🥇","Formula 1"=>"🏎️",
    "Hollywood"=>"🎥","Bollywood"=>"🇮🇳","Tollywood"=>"🌟","K-Drama & Cinema"=>"🇰🇷","Anime & J-Cinema"=>"🇯🇵","British Cinema"=>"🇬🇧",
    "Programming & Coding"=>"💻","AI & Machine Learning"=>"🤖","Gaming"=>"🎮","Social Media"=>"📱","Gadgets & Hardware"=>"⌨️","Cybersecurity"=>"🔐"
  }.freeze

  CAT_GRADIENTS = {
    "Science"     => "linear-gradient(135deg,#4f46e5,#7c3aed)",
    "History"     => "linear-gradient(135deg,#b45309,#d97706)",
    "Geography"   => "linear-gradient(135deg,#047857,#0ea5e9)",
    "Sports"      => "linear-gradient(135deg,#dc2626,#f97316)",
    "Movies & TV" => "linear-gradient(135deg,#7c2d12,#be123c)",
    "Technology"  => "linear-gradient(135deg,#0369a1,#4f46e5)"
  }.freeze

  SUB_GRADIENTS = [
    "linear-gradient(135deg,#4f46e5,#7c3aed)",
    "linear-gradient(135deg,#0369a1,#4f46e5)",
    "linear-gradient(135deg,#047857,#0ea5e9)",
    "linear-gradient(135deg,#7c2d12,#be123c)",
    "linear-gradient(135deg,#b45309,#d97706)",
    "linear-gradient(135deg,#6d28d9,#ec4899)"
  ].freeze

  def category_icon(cat)     = ICONS.fetch(cat, "🎯")
  def category_gradient(cat) = CAT_GRADIENTS.fetch(cat, "linear-gradient(135deg,#4f46e5,#9333ea)")
  def sub_gradient(index)    = SUB_GRADIENTS[index % SUB_GRADIENTS.size]
end
