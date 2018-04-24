require 'rest-client'
require 'json'
require 'pry-nav'

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('https://www.swapi.co/api/people/?page=1')
  character_hash = JSON.parse(all_characters)


  # film_hash = character_hash["results"].find do |hash|
  #   character == hash["name"].downcase
  # end
  num = 1
  while character_hash["next"] != nil
    film_hash = character_hash["results"].find do |hash|
      character == hash["name"].downcase
    end
    # binding.pry
    if film_hash == nil
      num += 1
      all_characters = RestClient.get("https://www.swapi.co/api/people/?page=#{num}")
      character_hash = JSON.parse(all_characters)
    else
      puts "character found on page #{num + 1}"
      return film_hash
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
  # some iteration magic and puts out the movies in a nice list
  films = films_hash["films"]
  films.map do |title|
    film_request = RestClient.get(title)
    film_title = JSON.parse(film_request)["title"]
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  puts parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
