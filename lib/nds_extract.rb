# Provided, don't edit
require 'directors_database'

# A method we're giving you. This "flattens"  Arrays of Arrays so: [[1,2],
# [3,4,5], [6]] => [1,2,3,4,5,6].

def flatten_a_o_a(aoa)
  result = []
  i = 0

  while i < aoa.length do
    k = 0
    while k < aoa[i].length do
      result << aoa[i][k]
      k += 1
    end
    i += 1
  end

  result
end

def movie_with_director_name(director_name, movie_data)
  { 
    :title => movie_data[:title],
    :worldwide_gross => movie_data[:worldwide_gross],
    :release_year => movie_data[:release_year],
    :studio => movie_data[:studio],
    :director_name => director_name
  }
end


# Your code after this point

def movies_with_director_key(name, movies_collection)
  movies_with_director_key_array = []
  movie_index = 0 
  
  while movie_index < movies_collection.length do
    movies_with_director_key_array << movie_with_director_name(name, movies_collection[movie_index])
    movie_index += 1 
  end
  movies_with_director_key_array
end

def find_gross_by_director_and_title (collection, index)
  a = 0 
  retrieved = []
  
  #Looking for #{director} and #{title}.    
  #step through directors_database 1x, for each entry, evaluate director + title from collection
  while a < directors_database.length do
    if directors_database[a][:name] == collection[index][:name]
      b = 0  
      found = false
      
      while b < directors_database[a][:movies].length && !found do
        if directors_database[a][:movies][b][:title] == collection[index][:title]
          retrieved << directors_database[a][:movies][b][:studio]
          retrieved << directors_database[a][:movies][b][:worldwide_gross]
          found = true
        end
        b += 1
      end
    end          
    a += 1
  end
  retrieved 
end

def gross_per_studio(collection)
  
  studio_index = 0 
  studio_gross_hash = {}

  #if collection array contains {studio + worldwide_gross}
  if collection[0][:studio] && collection[0][:worldwide_gross]
    studio_name = collection[studio_index][:studio]
    gross = collection[studio_index][:worldwide_gross]
  
  #if collection array containts {director + title}
  else # !collection[studio_index][:studio] || !collection[studio_index][:worldwide_gross]
      
    #Looking for #{director} and #{title}.    
    #step through directors_database 1x, for each entry, evaluate director + title from collection
    a = 0
    while a < directors_database.length do
      b = 0  
      while b < directors_database[a][:movies].length && !found do
        index = 0
        while index < collection.length do
          pp "Comparing #{directors_database[a][:movies][b][:title]} and #{collection[index][:title]}"
          if directors_database[a][:movies][b][:title] == collection[index][:title]
            studio = directors_database[a][:movies][b][:studio]
            gross = directors_database[a][:movies][b][:worldwide_gross]
            found = true
          end #if compare titles
          index += 1
        end #loop of collection
        b += 1
      end #loop of movies
      a += 1
    end #loop of directors


    #assign found values, either from collection or by association from directors_database
    if !studio_gross_hash[studio_name]
      studio_gross_hash[studio_name] = gross
    else
      studio_gross_hash[studio_name] += gross
    end

  studio_gross_hash
end

def movies_with_directors_set(source)
  director_index = 0 
  return_array = []
  
  while director_index < source.length do 
    director = source[director_index][:name]
    film_index = 0 
    
    while film_index < source[director_index][:movies].length do
      film_title = source[director_index][:movies][film_index][:title]
      return_array << [{:title => film_title, :director_name => director}]
      film_index += 1 
    end
    director_index += 1 
  end
  
  return_array
end

# ----------------    End of Your Code Region --------------------
# Don't edit the following code! Make the methods above work with this method
# call code. You'll have to "see-saw" to get this to work!

def studios_totals(nds)
  a_o_a_movies_with_director_names = movies_with_directors_set(nds)
  movies_with_director_names = flatten_a_o_a(a_o_a_movies_with_director_names)
  return gross_per_studio(movies_with_director_names)
end
