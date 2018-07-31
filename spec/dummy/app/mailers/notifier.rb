class Notifier < ApplicationMailer
  def welcome
    mail
  end

  def invitation(email, opt_arg = nil)
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

  def with_slim_template
    mail
  end
end