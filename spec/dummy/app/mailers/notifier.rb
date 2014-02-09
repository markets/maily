class Notifier < ActionMailer::Base
  default from: 'foo@foo.com'

  def welcome
    mail to: 'foo@foo.com'
  end
end