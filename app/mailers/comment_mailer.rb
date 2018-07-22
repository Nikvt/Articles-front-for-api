class CommentMailer < ApplicationMailer
  def comment_written(comment, article)
    @article = article
    @comment = comment
    mail to: @comment['author']['email'], subject: "You posted a new comment for: #{@article['title']}"
  end

  def comment_received(comment, article)
    @article = article
    @comment = comment
    mail to: @article['author']['email'], subject: "New comment for: #{@article['title']}"
  end
end