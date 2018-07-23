class MailToCommentWriter
  include Interactor

  def call
    CommentMailer.comment_written(context.comment, context.article).deliver_now
  end
end