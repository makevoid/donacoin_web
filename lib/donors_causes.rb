class DonorsCause
  
  def self.create(hash)    
    DonorsCauses.instance << hash
  end

end