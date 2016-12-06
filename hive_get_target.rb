#!/usr/bin/env ruby

require_relative 'BritishGasHive-6.5'

api = BritishGasHive.new('{{username}}', '{{password}}', 'RubyScript', true)
reciever = api.getReciever()
currentTemp = reciever["features"]["heating_thermostat_v1"]["targetHeatTemperature"]["displayValue"]
puts currentTemp

