DEFAULT_DONORS = [ 
  { id: 1, username: "virtuoid"      }, 
  { id: 2, username: "makevoid"      },
  { id: 3, username: "filippooretti" }, 
  { id: 4, username: "wouldgo"       },
]


# todo: move in models / db, use a real db for users

require "#{PATH}/lib/pool"
require "#{PATH}/lib/cause"
require "#{PATH}/lib/donor"
require "#{PATH}/lib/value"
require "#{PATH}/lib/donors_causes"


# initialize db with saved causes


causes = eval File.read("#{PATH}/db/causes.rb")
for cause in causes
  unless Cause.all.map{ |c| c[:name] }.include? cause[:name].to_s
    Cause.create cause
  end
end

Causes.instance.write


for donor in DEFAULT_DONORS
  unless Donor.all.map{ |d| d[:username] }.include? donor
    Donor.create username: donor
  end
end

Donors.instance.write