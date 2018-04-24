require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request

  all_characters = RestClient.get('http://www.swapi.co/api/people/')

  character_hash = JSON.parse(all_characters)

  hashes = character_hash["results"]

  hashes.each do |char_hash|
    if char_hash["name"] == character
      movies = char_hash["films"]
      # binding.pry
      # movie_titles = movies.collect do |url|
      # movie_info = RestClient.get("#{url}")
      # formatted = JSON.parse(movie_info)
      # movie_name = formatted["title"]
      # puts movie_name
     end
    end
  end




  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.




def parse_character_movies(films_hash)
  # binding.pry
      movie_titles = films_hash[0]["films"]
      # binding.pry
      movie_titles.map do |url|
        movie_info = RestClient.get(url)
        formatted = JSON.parse(movie_info)["title"]
      # movie_name = formatted["title"]
      # binding.pry
  end
end









def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  puts parse_character_movies(films_hash)
end


# show_character_movies("Luke Skywalker")
## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
