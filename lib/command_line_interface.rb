def welcome
  # puts out a welcome message here!
  puts "Welcome to Find Your Character: The Program"
end

def get_character_from_user
  puts "please enter a character"
  return input = gets.strip.downcase
  # use gets to capture the user's input. This method should return that input, downcased.
end
