class Value

  def self.all
    values = []
    DONORS_VALUE.each do |donor|
      miner_value = MINERS_VALUE.find{ |mv| mv[:uid] == donor[:uid] }
      puts miner_value.inspect
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