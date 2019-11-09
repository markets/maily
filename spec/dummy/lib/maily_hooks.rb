email = -> { 'foo@foo.com' }
emails = ['bar@foo.com']
message = -> { 'Hello!' }

Maily.hooks_for('Notifier') do |mailer|
  mailer.register_hook(:invitation, email)
  mailer.register_hook(:notify, emails)
  mailer.register_hook(:new_message, with_params: { message: message })
  mailer.register_hook(:recommendation, template_path: 'notifications', description: 'description')
  mailer.register_hook(:custom_template_name, template_name: 'invitation')
  mailer.register_hook(:generic_welcome)

  mailer.hide_email(:hidden)
end
