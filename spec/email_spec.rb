require 'spec_helper'

describe Maily::Email do
  let(:mailer) { Maily::Mailer.find('notifier') }

  context "with no arguments" do
    it "should not require hook" do
      email  = mailer.find_email('welcome')

      email.required_arguments.should be_blank
      email.require_hook?.should be_false
    end
  end

  context "with arguments" do
    let (:email) { mailer.find_email('invitation') }

    it "should require hook" do
      email.required_arguments.should be_present
      email.require_hook?.should be_true
    end

    it "should handle arguments successfully" do
      email.arguments.size.should == 1
      expect { email.call }.to_not raise_error
    end
  end

  it "should handle template_path via hook" do
    email = mailer.find_email('recommendation')
    email.template_path.should == 'notifications'
  end
end
