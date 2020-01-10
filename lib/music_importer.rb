 class MusicImporter
   attr_accessor :path

   @@all = []

   def initialize(path)
     @path = path
   end

   def files
     Dir.entries(path).reject {|file| file[0].include?(".")}
   end

   def import
     import_files = nil
     files.each do |file|
       import_files = Song.create_from_filename(file)
     end
     import_files
   end

 end
