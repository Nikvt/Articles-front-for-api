class ArticlesController < ApplicationController
  URL = 'http://localhost:3001/articles/'
  before_action :set_article, :get_comments, only: :show

  def index
    @articlesJS = call_api_wo_auth(URL)
  end

  def show
  end

  private

  def set_article
    @articleJS = call_api_wo_auth(URL + params[:id])
  end

  def get_comments
    @commentsJS = call_api_wo_auth(URL + params[:id] + '/comments')
  end
end
