class Genre 
  
  extend Concerns::Findable
  
  attr_accessor :name 
  @@all = []
  
  def initialize(name)
    @name = name
    @songs = []
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
  
  def self.create(name)
    genre = Genre.new(name)
    genre.name = genre 
    save
    genre
  end
  
  def songs 
    @songs 
  end
  
  def artists
    songs.collect {|song| song.artist}.uniq 
  end
  
end