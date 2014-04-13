class Utils
  
  def self.format_val(val)
    "#{val.to_s.reverse.gsub(/(\d{3})/, '\\1,').reverse} &euro;/c"
  end
  
end