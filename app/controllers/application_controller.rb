class ApplicationController < ActionController::Base
  require 'net/http'
  require 'json'

  def call_api_wo_auth(url)
    uri = URI(url)
    response = Net::HTTP.get(uri)
    JSON.parse(response)['data']
  end
end