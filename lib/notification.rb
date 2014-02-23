class Notification

  #TIME_UNIT = 1 # minutes: every time_unit one miner calls /notify_mining
  TIME_UNIT = 5 # seconds (dev): ui in dev mode calls notify every 5 secs

  def receive (uid, speed)
    if last_mining_time(uid) > (Time.now - TIME_UNIT)
      assign_value uid, speed
    else
      start_mining uid
    end

    puts MINERS_VALUE
  end

  # TODO: refactor

  def last_mining_time(uid)
    # TODO: call: check_active uid

    # updating (valid)
    Time.now - 4
    # not updating (invalid)
    # Time.now - 6
  end

  def check_active(uid)
    # TODO: implement
  end

  def assign_value(uid, speed)
    miner = MINERS_VALUE.find{ |min| min[:uid] == uid }
    miner[:value] += speed
    #R.incr
  end

  def update_active_miners(uid)
    ACTIVE_MINED << { uid: uid, time: Time.now }
  end

  def start_mining(uid)
    #update_active_miners uid
    ACTIVE_MINED << { uid: uid, time: Time.now }
  end

end
