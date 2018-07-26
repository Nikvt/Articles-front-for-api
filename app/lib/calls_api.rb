class CallsApi
  require 'net/http'
  require 'json'

  def initialize
  end

  def call(url, action, token = nil, item = nil)
    uri = URI(url)
    http = Net::HTTP.new(uri.host, uri.port)
    # http.use_ssl = true
    req = req_build(uri, action, token, item)
    res = http.request(req)
    JSON.parse(res.body) unless action == 'delete'
  end

  private

  def req_build(uri, action, token = nil, item = nil)
    case action
    when 'get'
      req = Net::HTTP::Get.new(uri.path)
    when 'login'
      req = Net::HTTP::Post.new(uri.path)
      req.set_form_data({"code" => token})
    when 'post'
      req = Net::HTTP::Post.new(uri.path, { 'Content-Type' => 'application/json', 'Authorization' => token })
      req.body = { 'data' => { 'attributes' => item } }.to_json
    when 'put'
      req = Net::HTTP::Put.new(uri.path, { 'Content-Type' => 'application/json', 'Authorization' => token })
      req.body = { 'data' => { 'attributes' => item } }.to_json
    when 'delete'
      req = Net::HTTP::Delete.new(uri.path, { 'Authorization' => token })
    end
    req
  end
end