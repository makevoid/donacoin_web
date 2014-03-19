class Notification

  #TIME_UNIT = 1 # minutes: every time_unit one miner calls /notify_mining
  TIME_UNIT = 5 # seconds (dev): ui in dev mode calls notify every 5 secs

  def receive(donor_id, cause_id, speed)
    if last_mining_time(donor_id) > (Time.now - TIME_UNIT)
      puts "assign"
      assign_value donor_id, cause_id, speed
    else
      puts "start"
      start_mining donor_id
    end
    
  end

  # TODO: refactor

  def last_mining_time(donor_id)
    # TODO: call: check_active uid

    # updating (valid)
    Time.now - 4
    # not updating (invalid)
    # Time.now - 6
  end

  def check_active(donor_id)
    # TODO: implement
  end

  def assign_value(donor_id, cause_id, speed)
    Redis::Donor.new.value_incr donor_id, speed
    Redis::Cause.new.value_incr cause_id, speed
    DonorsCause.update  donor_id: donor_id, cause_id: cause_id, speed: speed
  end

  def update_active_miners(donor_id)
    ACTIVE_MINED << { uid: donor_id, time: Time.now }
  end

  def start_mining(uid)
    #update_active_miners uid
    ACTIVE_MINED << { uid: donor_id, time: Time.now }
  end

end 