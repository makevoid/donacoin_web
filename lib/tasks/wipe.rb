path = File.expand_path "../../../", __FILE__
require "#{path}/config/env"


def say(message, &block)
  puts message
  block.call
  puts "done"
end

say "flushing the redis db" do
  R.flushdb
end

say "deleting db files" do
  `rm -f #{path}/db/causes.json`
  `rm -f #{path}/db/donors.json`
end