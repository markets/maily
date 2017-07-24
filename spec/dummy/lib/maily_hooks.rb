email = -> { 'foo@foo.com' }

Maily.hooks_for('Notifier') do |mailer|
  mailer.register_hook(:invitation, email)
  mailer.register_hook(:recommendation, template_path: 'notifications', description: 'description')
end
