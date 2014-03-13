class DonorsCause  
  
  def self.all
    DonorsCauses.instance.all
  end
  
  def self.update(hash)  # { value: 123, donor_id: 5, cause_id: 1 }
    cause = self.all.find{ |dc| dc[:donor_id] == hash[:donor_id] && dc[:cause_id] == hash[:cause_id] }
    hash_tmp = hash
    hash_tmp.delete :value 
    DonorsCauses.instance << hash_tmp if cause
    R.set "donors:#{dc[:donor_id]}:causes:#{dc[:cause_id]}", hash[:value]
  end

end