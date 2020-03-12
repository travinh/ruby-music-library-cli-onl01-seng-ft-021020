require 'pry'

class Song
  extend Concerns::Findable
  attr_accessor :name
  attr_reader :artist, :genre
  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    if artist != nil 
      self.artist=artist
    end 

    if genre != nil 
      self.genre=genre
    end 
  end 

  def self.all
    @@all
  end 

  def self.destroy_all
    @@all.clear
  end 

  def save
    @@all << self
  end 

  def self.create(name)
    song = Song.new(name)
    song.save
    song
  end 

  def artist=(name)
    @artist = name
    @artist.add_song(self)
  end 

  def genre=(genre)

    @genre=genre 
    @genre.songs << self if !@genre.songs.include?(self)
  end 


  def self.new_from_filename(file)
    array = file.split(" - ")
    song_name = array[1]
    artist_name = array[0]
    genre_name = array[2].chomp(".mp3")

    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre_name)
    self.new(song_name, artist, genre)
  end

  def self.create_from_filename(file)
    self.new_from_filename(file).save
  end 

end