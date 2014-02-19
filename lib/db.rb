class DB

  def self.read
    begin
      causes = JSON.parse File.read("#{PATH}/db/causes.json") 
      donors = JSON.parse File.read("#{PATH}/db/donors.json") 
    rescue Errno::ENOENT # file doesn't exists
    end
    { causes: causes, donors: donors }
  end
  
  def self.setup
    unless db = read
      @@causes = db[:causes]
      @@donors = db[:donors]
    else
      @@causes = []
      @@donors = []
    end
  end
  
  def self.causes
    setup
    @@causes
  end
  
  def self.donors
    setup
    @@donors
  end
  
  def self.write
    File.open("#{PATH}/db/causes.json", "w") do |file|
      file.write @@causes.to_json
    end
    File.open("#{PATH}/db/donors.json", "w") do |file|
      file.write @@donors.to_json
    end
  end
  
  def self.<<(cause)
    @@causes << cause
  end
  
end