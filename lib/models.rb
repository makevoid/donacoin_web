
DONORS_VALUE = [
  { uid: "123asda", username: "virtuoid", cause: "wikipedia" },
  { uid: "345asda", username: "makevoid", cause: "riotvan" },
]

MINERS_VALUE = [
  { uid: "123asda", value: 123 },
  { uid: "345asda", value: 001 },
] # separated from donors_value because of Redis incr functionality: es: R["min


class Value

  def self.all
    values = []
    DONORS_VALUE.each do |donor|
      miner_value = MINERS_VALUE.find{ |mv| mv[:uid] == donor[:uid] }
      value = donor.merge( value: miner_value[:value] )
      values << value
    end
    values
  end


  require "net/http"
  def self.calculate(speed, curr)
    url = URI("http://www.cryptocoincharts.info/v2/api/listCoins")
    resp = Net::HTTP.get url
    resp = JSON.parse(resp)

    entry = resp.find{ |r| r["id"] == curr }
    entry["price_btc"] * speed
  end

end

ACTIVE_MINED = [
  { uid: "123asda", time: Time.now-10 },
  { uid: "234asda", time: Time.now-1 }
]# periodically flush

