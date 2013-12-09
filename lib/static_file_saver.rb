class StaticFileSaver
  attr_accessor :path, :document

  def initialize(ember_path, document)
    self.path = static_file_path_for(ember_path)
    self.document = document
  end

  def save
    create_directory
    create_file
  end

  private

  def create_file
    File.open(@path + ".html", "w+") do |f|
      f.write(@document.to_s)
    end
  end

  def create_directory
    FileUtils.mkdir_p(File.dirname(@path))
  end

  def static_file_path_for(path)
    file_name = path.gsub("#!",'')
    file_name << 'index' if path.last == '/'
    "public/static" + file_name
  end

end
