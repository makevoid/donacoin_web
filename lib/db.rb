class DB
  
  def self.init_db(name)
    @@db_name = name
    read
  end
  
  def self.read
    @@collection = begin
      JSON.parse File.read("#{PATH}/db/#{@@db_name}.json")  
    rescue Errno::ENOENT # file doesn't exists
      []
    end
  end
  
  def self.all
    @@collection
  end
    
  def self.write
    File.open("#{PATH}/db/#{@@db_name}.json", "w") do |file|
      file.write @@collection.to_json
    end
  end
  
  def self.<<(entry)
    @@collection << entry
  end
  
end

class Causes < DB
  init_db "causes"  
end

class Donors < DB
  init_db "donors"
end