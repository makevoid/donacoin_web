class Donor
  def self.all
    Donors.instance.all
  end

  def self.top
    all
  end

end

class Redis  

  class Donor
    def create
      count = R.incr "donors_count"
      R.hset "donors:#{count}", "value", 0
      count      
    end

    def update(donor_id, val)
      exists = Donors.instance.all.any?{ |d| d[:id] == donor_id }
      if exists      
        value_incr donor_id, val
      else
        #TODO: Implement create as donors_causes do
      end 
    end


    def value_incr(donor_id, val)
      R.hincrby "donors:#{donor_id}", "value", val
      Donors.instance.update donor_id, value_get(donor_id)     
    end

    def value_get(donor_id)
      value = R.hget "donors:#{donor_id}", "value"
      value.to_i
    end
  end

  def donor
    Donor.new
  end

end

class Donor
  def self.create(donor_hash)
    id = ::R.donor.create
    Donors.instance << { id: id }.merge(donor_hash)
  end
end
