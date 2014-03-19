class DonorsCause  
  
  def self.all
    DonorsCauses.instance.all
  end
  
  def self.update(hash)  # { value: 123, donor_id: 5, cause_id: 1 }
    cause = self.all.find{ |dc| dc[:donor_id] == hash[:donor_id] && dc[:cause_id] == hash[:cause_id] }
    unless cause
      puts "cause not found #{hash}"
      return 
    end
    hash_tmp = hash
    hash_tmp.delete :value 
    key = "donors:#{hash[:donor_id]}:causes:#{hash[:cause_id]}"
    R.set key, hash[:value]
    DonorsCauses.instance << hash.merge( value: R.get(key) ) 
    DonorsCauses.instance.write
  end

end