class Artist
  extend Concerns::Findable
  attr_accessor :name, :song, :songs

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def save
    self.class.all << self
  end

  def self.create(artist)
    artist = Artist.new(artist)
    artist.save
    artist
  end

  def add_song(song)
    song.artist = self unless song.artist
    @songs << song unless @songs.include?(song)
  end

  def genres
    # returns a collection of genres for all of the artist's songs (artist has many genres through songs)
    # genres does not return duplicate genres if the artist has
    # more than one song of a particular genre
    # binding.pry
    self.songs.collect do |song|
      song.genre
    end.uniq
  end

end
