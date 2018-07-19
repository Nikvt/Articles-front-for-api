class ArticlesController < ApplicationController
  before_action :set_article, :get_comments, only: [:show, :edit, :update, :destroy]

  def index
    @articlesJS = call_api_wo_auth(ENV['URL'] + 'articles/')
  end

  def show
  end

  def new
  end

  def create
    article = article_params
    article['slug'] = article['title'].gsub(/\s+/, '-')
    article_id = call_api_post_item(ENV['URL'] + 'articles/', article, session[:api_token])
    if article_id['data']['id']
    redirect_to article_path(article_id['data']['id'])
    else
      render :new
    end
  end

  def edit
  end

  def update

  end

  def destroy

  end

  def login
    api_token = call_api_auth(ENV['URL'] + '/login', params[:code])
    create_session(api_token)
    redirect_to articles_path
  end

  def logout
    call_api_logout(ENV['URL'] + '/logout', session[:api_token])
    close_session
    redirect_to articles_path
  end

  private

  def set_article
    @articleJS = call_api_wo_auth(ENV['URL'] + 'articles/' + params[:id])
  end

  def get_comments
    @commentsJS = call_api_wo_auth(ENV['URL'] + 'articles/' + params[:id] + '/comments')
  end

  def article_params
    params.require(:article).permit(:title, :content)
  end
end
