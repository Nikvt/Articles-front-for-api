require 'rails_helper'

describe MailToCommentWriter do
  let(:comment) do
    {
        "attributes" => {
            "content" => "sDFESFSE",
            "user-name" => "Nikolay Terekhov",
            "user-email" => "nikvt@mail.ru"
        }
    }
  end

  let(:article) do
    {
        "id" => "57",
        "attributes" => {
            "title" => "He lives vicariously",
            "content" => "Qui providente",
            "user-name" => "John Smith",
            "user-email" => "nikvt@mail.ru"
        }
    }
  end

  subject(:context) { MailToCommentWriter.call(comment: comment, article: article) }

  describe ".call" do
    it "succeeds" do
      expect { context }.to change { ActionMailer::Base.deliveries.count }.by(1)
      expect(ActionMailer::Base.deliveries.last.to).to include(comment['attributes']['user-email'])
    end
  end
end