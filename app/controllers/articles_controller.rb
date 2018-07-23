class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :destroy, :add_comment]
  before_action :get_comments, only: [:show]

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

  def add_comment
    comment = comment_params
    comment = call_api_post_item(ENV['URL'] + 'articles/' + params[:id] + '/comments', comment, session[:api_token])
    MailsCommentCreation.call(comment: comment['data'], article: @articleJS)
    redirect_to article_path(params[:id])
  end

  def edit
  end

  def update
    article = article_params
    article['slug'] = article['title'].gsub(/\s+/, '-')
    article = call_api_put_item(ENV['URL'] + 'articles/' + params[:id], article, session[:api_token])
    if article['data']['id']
      redirect_to article_path(article['data']['id'])
    else
      render :new
    end
  end

  def destroy
    call_api_delete(ENV['URL'] + 'articles/' + params[:id], session[:api_token])
    redirect_to articles_path
  end

  def login
    response = call_api_auth(ENV['URL'] + '/login', params[:code])
    create_session(response)
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

  def comment_params
    params.require(:comment).permit(:content)
  end
end