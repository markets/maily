Maily.hooks_for('Notifier') do |mailer|
  mailer.register_hook(:invitation, 'foo@foo.com')
end