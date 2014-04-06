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

    def update(cause, val)
      exists = Causes.instance.all.any?{ |c| c[:id] == cause_id }
      if exists      
        value_incr cause_id, val
      else
        #TODO: Implement create as donors_causes do
      end 
    end

    def value_incr(cause_id, val)
      R.hincrby "causes:#{cause_id}", "value", val
      Causes.instance.update cause_id, value_get(cause_id) 
    end

    def value_get(cause_id)
      value = R.hget "causes:#{cause_id}", "value"
      value.to_i
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