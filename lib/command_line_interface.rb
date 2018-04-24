def welcome
  puts "Hello, how's it going?"
end

def get_character_from_user
  puts "please enter a character"
  response = gets.chomp
  response.downcase
  # use gets to capture the user's input. This method should return that input, downcased.
end
