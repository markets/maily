class Notifier < ActionMailer::Base
  default from: 'foo@foo.com', to: 'bar@bar.com'

  def welcome
    mail
  end

  def invitation(email, opt_arg = nil)
    mail
  end

  def recommendation(email)
    mail template_path: 'notifications'
  end
end