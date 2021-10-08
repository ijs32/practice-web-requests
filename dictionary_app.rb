require "http"
require "launchy"
system "clear"

puts "welcome to the dictionary"
user_input = true
while user_input
  puts "enter a word you would like a definition for, or 'q' to quit: "
  word = gets.chomp
  if word != "q"
    user_input = true
  else
    user_input = false
  end
  if user_input
    puts "would you like 'audio', or 'written'?"
    choice = gets.chomp
    if choice == "audio"
      audio_def_request = HTTP.get("https://api.wordnik.com/v4/word.json/#{word}/audio?useCanonical=false&limit=50&api_key=YOUR_KEY_GOES_HERE")
      audio_def_request = audio_def_request.parse(:json)
      file_url = audio_def_request[0]["fileUrl"]
      Launchy.open(file_url)
    elsif choice == "written"
      written_def_request = HTTP.get("https://api.wordnik.com/v4/word.json/#{word}/definitions?limit=200&includeRelated=false&useCanonical=false&includeTags=false&api_key=YOUR_KEY_GOES_HERE")
      written_def_request = written_def_request.parse(:json)
      written_def = written_def_request[1]["text"]
      puts "#{word}: #{written_def}"
    end
  end
end
