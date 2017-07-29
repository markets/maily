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

  describe 'validate_arguments' do
    it 'emails with no arguments required' do
      email = mailer.find_email('welcome')
      expect(email.validate_arguments).to eq [true, nil]

      email.arguments = ["asd"]
      expect(email.validate_arguments[1]).to  eq("welcome email requires at the most 0 arguments, passed 1")
    end

    it 'emails with arguments required' do
      email = mailer.find_email('invitation')
      expect(email.validate_arguments).to eq [true, nil]

      email = mailer.find_email('recommendation')
      expect(email.validate_arguments[1]).to eq("recommendation email requires at least 1 arguments, passed 0")
    end
  end
end
