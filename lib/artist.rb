class Artist 
  
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
  
  def songs 
    @songs 
  end
  
  def add_song(song)
    @songs << song unless @songs.include?(song)
    song.artist = self if song.artist!=self 
    song
    
  end
  
  def self.create(name)
    artist = Artist.new(name)
    artist.name = name 
    artist
  end
  
  def genres 
    @genres = []
    @songs.each do |song|
      if @genres.include?(song.genre)
        nil 
      else 
        @genres << song.genre 
      end
    end
    @genres
  end
  
  
  
end