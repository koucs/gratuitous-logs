require "rails_helper"

RSpec.describe MyMailer, :type => :mailer do
  describe "send_contact" do
    let(:mail) { MyMailer.send_contact }

    it "renders the headers" do
      expect(mail.subject).to eq("Send contact")
      expect(mail.to).to eq(["kou.cshu@gmail.com"])
      expect(mail.from).to eq(["app31918161@heroku.com"])
    end

    # it "renders the body" do
    #   expect(mail.body.encoded).to match("Hi")
    # end
  end

end
