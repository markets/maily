email = -> { 'foo@foo.com' }
emails = ['bar@foo.com']
message = -> { 'Hello!' }
free_trial_account = -> { OpenStruct.new({ name: 'Nicolas Cage' }) }
gold_account = -> { OpenStruct.new({ name: 'John Doe' }) }

Maily.hooks_for('Notifier') do |mailer|
  mailer.register_hook(:with_arguments, email)
  mailer.register_hook(:with_array_arguments, emails)
  mailer.register_hook(:with_params, with_params: { message: message })
  mailer.register_hook(:custom_template_path, template_path: 'notifications', description: 'description')
  mailer.register_hook(:custom_template_name, template_name: 'custom_template')
  mailer.register_hook(:from_other_class)
  mailer.register_hook(:version, free_trial_account, version: 'Free trial account')
  mailer.register_hook(:version, gold_account, version: 'Gold account')

  mailer.hide_email(:hidden)
end
