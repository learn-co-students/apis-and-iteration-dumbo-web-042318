require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  num = 1
  all_characters = RestClient.get("http://www.swapi.co/api/people/?page=#{num}")
  character_hash = JSON.parse(all_characters)


  #get all character from all pages
  char_from_all_pages = []
  char_from_all_pages << character_hash["results"]

  num = 2

  while character_hash["next"] != nil


    character_hash = JSON.parse(RestClient.get("http://www.swapi.co/api/people/?page=#{num}"))
    char_from_all_pages << character_hash["results"]
    num += 1
    #binding.pry
    #character_hash["next"] = JSON.parse(RestClient.get("http://www.swapi.co/api/people/?page=#{num}"))
  end

    char_from_all_pages.flatten!
    array = []


    char_from_all_pages.each do |char_hash|

        #check if the hash has the character name in that page
        #if not, go to the next page
        if char_hash["name"] == character

          char_hash["films"].each do |movie_url|
            array << JSON.parse(RestClient.get(movie_url))

          end
        end
    end
    array


  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
end

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  films_hash.each_with_index do |movie, i|
    puts "#{i + 1} #{movie["title"]}"
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
