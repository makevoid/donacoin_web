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

  def update(cause_id, value)
    val = @collection.find { |v| v[:id] == cause_id }
    val.each { |k,v| val[k] = value if k == :value }
    write
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

  def update(donor_id, value)
    val = @collection.find { |v| v[:id] == donor_id }
    val.each { |k,v| val[k] = value if k == :value }
    write
  end

end

class DonorsCauses < DB

  def self.instance
    @@instance ||= new
  end

  def initialize
    @db_name = "donors_causes"
    read
  end

  def update(hash)    
    val = @collection.find { |v| v[:donor_id] == hash[:donor_id] && v[:cause_id] == hash[:cause_id]}
    val.each { |k,v| val[k] = hash[:value] if k == :value }
    write
  end

end