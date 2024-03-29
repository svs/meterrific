require 'data_mapper'
require_relative './models/cab_meter.rb'
require_relative './models/api_key.rb'
require_relative './domain/meter_reading.rb'
def database_url(env)
  ENV['DATABASE_URL'] ||
      {
        "dev" => "",
        "staging" => ""
      }[env] || 'postgres://svs@localhost/meteriffic'
end

puts "Connecting to: #{ENV['RACK_ENV']} => #{database_url(ENV['RACK_ENV'])}"

DataMapper.setup(:default,database_url(ENV['RACK_ENV']))
DataMapper.finalize

