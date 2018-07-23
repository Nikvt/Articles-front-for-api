class CommentMailer < ApplicationMailer
  def comment_written(comment, article)
    @article = article
    @comment = comment
    mail to: @comment['attributes']['user-email'], subject: "You posted a new comment for: #{@article['attributes']['title']}"
  end

  def comment_received(comment, article)
    @article = article
    @comment = comment
    mail to: @article['attributes']['user-email'], subject: "New comment for: #{@article['attributes']['title']}"
  end
end