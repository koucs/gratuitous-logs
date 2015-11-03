require "rails_helper"

RSpec.describe MyMailer, :type => :mailer do
  describe "send_contact" do
    let(:mail) { MyMailer.send_contact }

    it "renders the headers" do
      expect(mail.subject).to eq("Send contact")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
