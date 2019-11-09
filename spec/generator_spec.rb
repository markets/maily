RSpec.describe Maily::Generator do
  it '.run generates valid fixtures and hooks for current application' do
    expect(Maily::Generator.run).to eq <<-HOOKS.strip_heredoc
      email = ''
      emails = []

      Maily.hooks_for('Notifier') do |mailer|
        mailer.register_hook(:invitation, email)
        mailer.register_hook(:notify, emails)
        mailer.register_hook(:recommendation, email)
      end
    HOOKS
  end
end
