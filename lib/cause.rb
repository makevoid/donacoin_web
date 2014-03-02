class Cause
  def self.all
    Causes.instance.all
  end
end

class Redis

  class Cause
    def create
      count = R.incr "causes_count"
      R.hset "causes:#{count}", "value", 0
      count
    end

    def value_incr(cause_id, val)
      R.hincrby "causes:#{cause_id}", "value", val
    end

    def value_get(cause_id)
      R.hget "causes:#{cause_id}", "value"
    end
  end

  def cause
    Cause.new
  end

end

class Cause
  def self.create(cause_hash)
    id = ::R.cause.create
    Causes.instance << { id: id }.merge(cause_hash)
  end
end