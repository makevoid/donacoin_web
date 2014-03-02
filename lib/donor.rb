class Donor
  def self.all
    DONORS_VALUE.map{ |donor_value| { username: donor_value[:username] } }
  end

  def self.top
    DONORS_VALUE.map{ |donor_value| { username: donor_value[:username] } }
  end
end