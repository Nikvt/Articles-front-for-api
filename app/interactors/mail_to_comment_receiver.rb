class MailToCommentReceiver
  include Interactor

  def call
    CommentMailer.comment_received(context.comment, context.article).deliver_now
  end
end