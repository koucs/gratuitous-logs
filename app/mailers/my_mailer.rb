class MyMailer < ActionMailer::Base
  default from: "app31918161@heroku.com",
    charset: 'UTF-8'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.my_mailer.send_contact.subject
  #
  def send_contact(subject: subject, body: body)
    @greeting = body
    mail to: "kou.cshu@gmail.com", subject: subject
  end
end
