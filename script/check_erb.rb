# frozen_string_literal: true

require "erb"

files = Dir.glob("app/views/**/*.html.erb").sort

if files.empty?
  puts "No html.erb files found"
  exit 0
end

failures = []

files.each do |path|
  source = File.read(path)

  begin
    # Compile ERB to Ruby to catch malformed ERB tags and Ruby syntax inside tags.
    ERB.new(source, trim_mode: "-").src
    puts "OK: #{path}"
  rescue StandardError => e
    failures << [path, e]
    warn "FAIL: #{path}"
    warn "  #{e.class}: #{e.message}"
  end
end

if failures.any?
  warn "\n#{failures.size} html.erb file(s) failed ERB compilation"
  exit 1
end

puts "\nAll html.erb files passed ERB compilation"
