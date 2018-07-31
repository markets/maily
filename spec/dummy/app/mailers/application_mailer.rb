class ApplicationMailer < ActionMailer::Base
  default from: 'foo@foo.com', to: 'bar@bar.com'

  def generic_welcome
    mail
  end
end