#!/usr/bin/env ruby
require 'uri' 
require 'net/http' 
require 'json' 
class BritishGasHive
  @session = nil
  def initialize(username, password, caller, bg = false)
    @uri = URI("https://api-prod.bgchprod.info/omnia")
  
    @session = self.login(username, password, caller)
    @username = username
    @password = password
  end
  def login(username, password, caller)
    http = Net::HTTP.new(@uri.host, @uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new("#{@uri.path}/auth/sessions")
    request.body = '{
    "sessions": [{
        "username": "' + username +'",
        "password": "' + password + '",
        "caller": "WEB"
      }]
    }'
    request["Content-Type"] = "application/vnd.alertme.zoo-6.5+json"
    request["Accept"] = "application/vnd.alertme.zoo-6.5+json"
    request["X-Omnia-Client"] = "Hive Web Dashboard"
    response = http.request(request)
    json = JSON.parse(response.body)
    @session = json["sessions"][0]["id"]

  end

  def getHeader
    return { "Content-Type" => "application/vnd.alertme.zoo-6.5+json",
    "Accept" => "application/vnd.alertme.zoo-6.5+json",
    "X-Omnia-Client" => "Hive Web Dashboard",
    "X-Omnia-Access-Token" => @session }
  end

  def getReciever()
    http = Net::HTTP.new(@uri.host, @uri.port)
    http.use_ssl = true
    header = self.getHeader()
    req = Net::HTTP::Get.new("#{@uri.path}/nodes", header)
    res = http.request(req)
    json = JSON.parse(res.body)
    json["nodes"][0]
    
  end
 
end
