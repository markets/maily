RSpec.describe Maily::Generator do
  it '.run generates valid fixtures and hooks for current application' do
    expect(Maily::Generator.run).to eq <<-HOOKS.strip_heredoc
      email = ''
      emails = []

      Maily.hooks_for('Notifier') do |mailer|
        mailer.register_hook(:custom_template_path, email)
        mailer.register_hook(:with_arguments, email)
        mailer.register_hook(:with_array_arguments, emails)
      end
    HOOKS
  end
end
