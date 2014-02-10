require 'spec_helper'

describe Maily::Email do
  let(:mailer) { Maily::Mailer.find('notifier') }

  context "with no arguments" do
    let (:email) { mailer.find_email('welcome') }

    it "should not require hook" do
      expect(email.required_arguments).to be_blank
      expect(email.require_hook?).to be_false
    end

    it ".call" do
      expect { email.call }.to_not raise_error
    end
  end

  context "with arguments" do
    let (:email) { mailer.find_email('invitation') }

    it "should require hook" do
      expect(email.required_arguments).to be_present
      expect(email.require_hook?).to be_true
    end

    it "should handle arguments successfully" do
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
end
