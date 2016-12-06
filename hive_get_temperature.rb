#!/usr/bin/env ruby

require_relative 'BritishGasHive-6.5'

api = BritishGasHive.new('{{username}}', '{{password}}', 'RubyScript', true)
reciever = api.getReciever()
currentTemp = reciever["features"]["temperature_sensor_v1"]["temperature"]["displayValue"]
puts currentTemp

