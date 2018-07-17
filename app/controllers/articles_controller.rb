class ArticlesController < ApplicationController
  before_action :set_article, :get_comments, only: :show

  def index
    @articlesJS = call_api_wo_auth(ENV['URL'] + 'articles/')
  end

  def show
  end

  private

  def set_article
    @articleJS = call_api_wo_auth(ENV['URL'] + 'articles/' + params[:id])
  end

  def get_comments
    @commentsJS = call_api_wo_auth(ENV['URL'] + 'articles/' + params[:id] + '/comments')
  end
end
