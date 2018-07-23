class MailsCommentCreation
  include Interactor::Organizer

  organize MailToCommentWriter, MailToCommentReceiver
end