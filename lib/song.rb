class Song 
  
  require 'pry'
  
  attr_accessor :name
  attr_reader :artist, :genre
  
  @@all = []
  
  def initialize(name,artist=nil, genre =nil)
    @name = name
    self.artist=(artist) if artist
    self.genre=(genre) if genre
    save
    
  end
  
  def save
    @@all << self
  end
  
  def self.destroy_all
    @@all.clear
  end
  
  def self.all
    @@all
  end
  
  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end
  
  def genre=(genre)
    @genre = genre
    genre.song << self unless genre.song.include?(self)
  end
  
  def self.create(name)
    song = Song.new(name)
    song.name = name 
    song
    
  end
  
  def self.find_by_name(name)
    @@all.detect {|song| song.name == name}
  end
  
  def self.find_or_create_by_name(name)
    find_by_name(name) || create(name)
  end
  
  def self.new_from_filename(filename)
    filename_arr  = filename.split(" - ")
    song_name = filename_arr[1]
    artist_name = filename_arr[0]
    genre_name = filename_arr[2].split(".mp3")[0]
    @name = genre_name
    
    
    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre_name)
    self.new(song_name,artist,genre)
    
  end
  
  def self.create_from_filename(filename)
    song = Song.new_from_filename(filename)
    song.save
   
  end
  
   def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genres
    @new_array = []
    @songs.each do |song|
      if @new_array.include?(song.genre)
        nil
      else
        @new_array << song.genre
      end
    end
    @new_array
  end

  
  
  
  
end