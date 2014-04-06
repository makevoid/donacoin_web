class DonorsCause  
  
  def self.all
    DonorsCauses.instance.all
  end
  
  def update(hash)  # { value: 123, donor_id: 5, cause_id: 1 }        
    exists = DonorsCauses.instance.all.any?{ |dc| dc[:donor_id] == hash[:donor_id] && dc[:cause_id] == hash[:cause_id] }    
    rkey = "donors:#{hash[:donor_id]}:causes:#{hash[:cause_id]}"      
    if exists      
      value_incr rkey, hash
    else
      self.create rkey, hash
    end        
  end

  def value_incr(key, hash)
    value = R.incrby key, hash[:value]                
    hash.each { |k,v| hash[k] = R.get(key).to_i if k == :value }
    DonorsCauses.instance.update(hash)
  end

  def create(key, hash)
    R.set key, hash[:value]
    DonorsCauses.instance << hash.merge( value: R.get(key) ) 
    DonorsCauses.instance.write
  end

end