class Notifier < ApplicationMailer
  def welcome
    mail
  end

  def invitation(email, opt_arg = nil)
    mail
  end

  def new_message
    @message = params[:message]
    mail
  end

  def notify(emails)
    mail
  end

  def recommendation(email)
    mail template_path: 'notifications'
  end

  def custom_template_name
    mail template_name: 'invitation'
  end

  def hidden
    mail
  end

  def multipart
    mail
  end

  def only_text
    mail
  end

  def with_slim_template
    mail
  end

  def with_inline_attachments
    attachments.inline['image.jpg'] = File.read(Rails.root.join("public/favicon.ico"))
    mail
  end
end
