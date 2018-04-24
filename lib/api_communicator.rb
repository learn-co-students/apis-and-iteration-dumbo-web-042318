require 'rest-client'
require 'json'
require 'pry'
def getcharname(name)

end
def get_character_movies_from_api(character)
  puts "#{character} appears in the following movies: "
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)

i = 0
arr =[]

  char_array = character_hash["results"]
    char_array.each do |characters|
        if characters["name"].downcase == character.downcase
          characters["films"].each do |film|
            movie = RestClient.get(film)
            movie_hash = JSON.parse(movie)
            arr[i] = movie_hash
            i+=1
          end
        end
      end

return arr
end


def parse_character_movies(films_hash)

  films_hash.each do |films|
    puts films["title"]
  end


end

#parse_character_movies(get_character_movies_from_api("Luke Skywalker"))

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end


## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
