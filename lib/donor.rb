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

    def value_incr(donor_id, val)
      R.hincrby "donors:#{donor_id}", "value", val
    end

    def value_get(donor_id)
      R.hget "donors:#{donor_id}", "value"
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
