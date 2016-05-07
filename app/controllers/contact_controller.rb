class ContactController < ApplicationController
  def new
    prepare_meta_tags( title: "CONTACT" )
    @contact_data = {
        "name": "",
        "subject": "",
        "email": "",
        "content": ""
    }
    @contact_data = flash[:contact_data] if flash[:contact_data]
    @error_message = flash[:error_message]
  end

  def create
    prepare_meta_tags( title: "CONTACT" )
    @contact_data = params["contact_data"]

    subject = "【koucs.com】"+@contact_data["subject"]
    content = @contact_data["content"]

    MyMailer.send_contact(
        subject: subject,
        body: content
    ).deliver

  end

  def confirm
    prepare_meta_tags( title: "CONTACT" )
    @contact_data = params["contact_data"]

    flash[:error_message] = ""
    if @contact_data["name"] == "" || @contact_data["content"] == "" || @contact_data["email"] == ""
        flash[:error_message] << "名前(Name)欄　" if @contact_data["name"] == ""
        flash[:error_message] << "メールアドレス(Mail Address)欄　" if @contact_data["email"] == ""
        flash[:error_message] << "本文(Content)欄　" if @contact_data["content"] == ""
        flash[:error_message] << "が空白です"

        flash[:contact_data] = @contact_data

        redirect_to new_contact_path
    end
  end
end
