class DB

  attr_accessor :collection

  def read
    @collection = begin
      entries = JSON.parse File.read("#{PATH}/db/#{@db_name}.json")
      # TODO: refactor method outside (named: hash keys to symbols)
      entries.map do |entry|
        hash = {}
        entry.each do |key, value|
          hash[key.to_sym] = value
        end
        hash
      end
    rescue Errno::ENOENT # file doesn't exists
      []
    end
  end

  def all
    @collection
  end

  def write
    File.open("#{PATH}/db/#{@db_name}.json", "w") do |file|
      file.write @collection.to_json
    end
    true
  end

  def <<(entry)
    @collection << entry
  end

end


class Causes < DB

  def self.instance
    @@instance ||= new
  end

  def initialize
    @db_name = "causes"
    read
  end

end

class Donors < DB

  def self.instance
    @@instance ||= new
  end

  def initialize
    @db_name = "donors"
    read
  end

end