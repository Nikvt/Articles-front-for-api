class ApplicationController < ActionController::Base

  def calls
    CallsApi.new
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