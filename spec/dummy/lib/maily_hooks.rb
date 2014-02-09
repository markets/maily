Maily.hooks_for('Notifier') do |mailer|
  mailer.register_hook(:invitation, 'foo@foo.com')
  mailer.register_hook(:recommendation, template_path: 'notifications')
end