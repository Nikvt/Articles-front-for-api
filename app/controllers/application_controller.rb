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
    # http.use_ssl = true
    req = Net::HTTP::Post.new(uri.path, {'Content-Type' => 'application/json', 'Authorization' => api_token})
    req.body = { 'data' => { 'attributes' => item } }.to_json
    res = http.request(req)
    JSON.parse(res.body)
  end

  def call_api_put_item(url, item, api_token)
    uri = URI(url)
    http = Net::HTTP.new(uri.host, uri.port)
    # http.use_ssl = true
    req = Net::HTTP::Put.new(uri.path, {'Content-Type' => 'application/json', 'Authorization' => api_token})
    req.body = { 'data' => { 'attributes' => item } }.to_json
    res = http.request(req)
    JSON.parse(res.body)
  end

  def call_api_delete(url, api_token)
    uri = URI(url)
    http = Net::HTTP.new(uri.host, uri.port)
    # http.use_ssl = true
    req = Net::HTTP::Delete.new(uri.path, {'Authorization' => api_token})
    http.request(req)
  end

  def call_api_auth(url, git_token)
    uri = URI(url)
    http = Net::HTTP.new(uri.host, uri.port)
    # http.use_ssl = true
    req = Net::HTTP::Post.new(uri.path)
    req.set_form_data({"code" => git_token})
    res = http.request(req)
    JSON.parse(res.body)
  end

  def call_api_logout(url, api_token)
    uri = URI(url)
    http = Net::HTTP.new(uri.host, uri.port)
    # http.use_ssl = true
    req = Net::HTTP::Delete.new(uri.path, {'Authorization' => api_token})
    http.request(req)
  end

  def create_session(data)
    session[:user_id] = data['data']['relationships']['user']['data']['id']
    session[:api_token] = data['data']['attributes']['token']
  end

  def close_session
    session[:user_id] = nil
    session[:api_token] = nil
  end
end