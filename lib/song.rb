 class Song
   extend Concerns::Findable
   attr_reader :artist, :genre
   attr_accessor :name

   @@all = []

   def initialize(name, artist = nil, genre = nil)
     @name = name
     self.artist = artist if artist
     self.genre = genre if genre
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

   def self.create(name)
     song = Song.new(name)
     song.save
     song
   end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    genre.songs << self unless genre.songs.include?(self)
    @genre = genre
  end

  def self.new_from_filename(filename)
    song_artist, song_name, song_genre = filename.chomp(".mp3").split(" - ")
    song = self.new(song_name)
    song.artist = Artist.find_or_create_by_name(song_artist)
    song.genre = Genre.find_or_create_by_name(song_genre)
    song
  end

  def self.create_from_filename(filename)
    song = new_from_filename(filename)
    song.save
  end

end
