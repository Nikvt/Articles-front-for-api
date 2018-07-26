class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :destroy, :add_comment]
  before_action :get_comments, only: [:show]

  def index
    @articlesJS = calls.call(ENV['URL'] + 'articles/', 'get')['data']
  end

  def show
  end

  def new
  end

  def create
    article = article_params
    article['slug'] = article['title'].gsub(/\s+/, '-')
    article_id = calls.call(ENV['URL'] + 'articles/', 'post', session[:api_token], article)['data']['id']
    if article_id
    redirect_to article_path(article_id)
    else
      render :new
    end
  end

  def add_comment
    comment = comment_params
    comment = calls.call(ENV['URL'] + 'articles/' + params[:id] + '/comments', 'post', session[:api_token], comment)
    MailsCommentCreation.call(comment: comment['data'], article: @articleJS)
    redirect_to article_path(params[:id])
  end

  def edit
  end

  def update
    article = article_params
    article['slug'] = article['title'].gsub(/\s+/, '-')
    article = calls.call(ENV['URL'] + 'articles/' + params[:id], 'put', session[:api_token], article)['data']['id']
    if article
      redirect_to article_path(article)
    else
      render :new
    end
  end

  def destroy
    calls.call(ENV['URL'] + 'articles/' + params[:id], 'delete', session[:api_token])
    redirect_to articles_path
  end

  def login
    response = calls.call(ENV['URL'] + '/login', 'login', params[:code])
    create_session(response)
    redirect_to articles_path
  end

  def logout
    calls.call(ENV['URL'] + '/logout', 'delete', session[:api_token])
    close_session
    redirect_to articles_path
  end

  private

  def set_article
    @articleJS = calls.call(ENV['URL'] + 'articles/' + params[:id], 'get')['data']
  end

  def get_comments
    @commentsJS = calls.call(ENV['URL'] + 'articles/' + params[:id] + '/comments', 'get')['data']
  end

  def article_params
    params.require(:article).permit(:title, :content)
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end