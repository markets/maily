require 'spec_helper'

describe Maily::Email do
  let(:mailer) { Maily::Mailer.find('notifier') }

  context "with no arguments" do
    let (:email) { mailer.find_email('welcome') }

    it "should not require hook" do
      expect(email.required_arguments).to be_blank
      expect(email.require_hook?).to be false
    end

    it ".call" do
      expect { email.call }.to_not raise_error
    end
  end

  context "with arguments" do
    let (:email) { mailer.find_email('invitation') }

    it "should require hook" do
      expect(email.required_arguments).to be_present
      expect(email.require_hook?).to be true
    end

    it 'should handle lazy arguments successfully' do
      expect(email.arguments).to be_present
      expect(email.arguments.size).to eq(email.required_arguments.size)
    end

    it 'should handle not lazy arguments successfully' do
      allow(email).to receive(:email).and_return('foo@foo.com')
      expect(email.arguments).to be_present
      expect(email.arguments.size).to eq(email.required_arguments.size)
    end

    it ".call" do
      expect { email.call }.to_not raise_error
    end
  end

  it "should handle template_path via hook" do
    email = mailer.find_email('recommendation')
    expect(email.template_path).to eq('notifications')
  end

  it "should handle description via hook" do
    email = mailer.find_email('recommendation')
    expect(email.description).to eq('description')
  end

  describe 'correct_number_of_arguments?' do
    let (:email) { mailer.find_email('invitation') }

    it 'when it lacks of arguments' do
      allow_any_instance_of(Maily::Email).to receive(:parameters).and_return([])

      expect(email.correct_number_of_arguments?).to be(false)
    end

    it 'when there is a correct number of arguments' do
      allow_any_instance_of(Maily::Email).to receive(:parameters).and_return([[:req, 'email'], [:opt, 'optional']])

      expect(email.correct_number_of_arguments?).to be(true)
    end
  end
end
