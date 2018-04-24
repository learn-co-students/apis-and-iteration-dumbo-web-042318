require 'rest-client'
require 'json'
require 'pry'
require 'awesome_print'

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)

  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  character_hash["results"].each do |character_info|
      if character_info["name"].downcase == character
        # character_info.each do |attribute, data|
        #   binding.pry
        # end
        return character_info["films"].collect do |film_url|
          film_info = RestClient.get(film_url)
          film_hash = JSON.parse(film_info)
        end
      end
    end
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
end

# ap get_character_movies_from_api("C-3PO")

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  film_titles = []
    films_hash.each do |film_details|
      film_titles << film_details["title"]
    end

    # ap film_titles
    film_titles.each.with_index do |title, index|
      #binding.pry
      puts "#{index+1} #{title}"
    end
end

# parse_character_movies(get_character_movies_from_api("C-3PO"))




def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
