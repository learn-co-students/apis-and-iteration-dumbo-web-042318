require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)

  films = []

  character_hash["results"].each do |ch|
    ch.collect do |info, data|
      if info == "name" && data.downcase.include?(character.downcase)
        films << ch["films"]
      end
    end
  end

  films_arr = films.flatten
  movie_info_arr = []

  films_arr.each do |url|
    movie_info = RestClient.get(url)
    movie_hash = JSON.parse(movie_info)
    movie_info_arr << movie_hash
  end
movie_info_arr
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
  films_hash.each do |data|
    data.each do |k,v|
      if k == "title"
        puts v
      end
    end
  end

  # some iteration magic and puts out the movies in a nice list
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end


## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
