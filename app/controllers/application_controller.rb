class ApplicationController < ActionController::Base
  require 'net/http'
  require 'json'

  def call_api_wo_auth(url)
    uri = URI(url)
    response = Net::HTTP.get(uri)
    JSON.parse(response)['data']
  end

  def call_api_post_item(url, item, api_token)
    uri = URI(url)
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Post.new(uri.path, {'Content-Type' =>'application/json', 'Authorization' => api_token})
    req.body = { 'data' => { 'attributes' => item } }.to_json
    res = http.request(req)
    JSON.parse(res.body)
  end

  def call_api_auth(url, git_token)
    uri = URI(url)
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Post.new(uri.path)
    req.set_form_data({"code" => git_token})
    res = http.request(req)
    JSON.parse(res.body)['data']['attributes']['token']
  end

  def call_api_logout(url, api_token)
    uri = URI(url)
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Delete.new(uri.path, {'Authorization' => api_token})
    http.request(req)
  end

  def create_session(api_token)
    session[:api_token] = api_token
  end

  def close_session
    session[:api_token] = nil
  end
end