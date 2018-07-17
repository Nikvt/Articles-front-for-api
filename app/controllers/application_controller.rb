class ApplicationController < ActionController::Base
  require 'net/http'
  require 'json'

  def call_api_wo_auth(url)
    uri = URI(url)
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Get.new(uri.path)
    res = http.request(req)
    JSON.parse(res.body)['data']
  end
end