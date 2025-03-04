require_relative 'lib/gtts'

# Test basic functionality
puts "Testing GTTS Ruby..."
puts "Available languages: #{Gtts.languages.count}"
puts "Creating MP3..."

begin
  tts = Gtts::GTTS.new("Well, let me tell you about my weekend, which was nothing short of a whirlwind. Initially, I embarked on a mission to organize my closet, as it seemed that chaos had established its headquarters there. Following this, I was struck by the realization that I had overlooked my dear friend's birthday, a grievous oversight given our longstanding friendship. Consequently, I felt compelled to make amends, so, I called her and, much to my relief, she forgave me. Subsequently, seeking some respite, I indulged in a movie, although my plans were thwarted when I succumbed to an unwelcome slumber halfway through. As a result, I awoke shocked to find popcorn strewn about like confetti. Therefore, if ever there was a weekend that epitomized pandemonium blended with unintended comedy, this was it.", lang: "en")
  tts.save("test.mp3")
  puts "Successfully created test.mp3"
rescue StandardError => e
  puts "Error: #{e.message}"
end
