class ApplicationMailer < ActionMailer::Base
  default from: 'foo@foo.com', to: 'bar@bar.com'

  def from_other_class
    mail template_path: 'notifier', template_name: 'custom_template'
  end
end
