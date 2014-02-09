require 'spec_helper'

describe "Maily::Email" do
  it "should load emails" do
    mailer = Maily::Mailer.find('notifier')
    mailer.emails.size.should == 2
  end

  it "should not require hook if method does not have arguments" do
    mailer = Maily::Mailer.find('notifier')
    email  = mailer.find_email('welcome')

    email.required_arguments.should be_blank
    email.require_hook?.should be_false
  end

  it "should require hook if method does have arguments" do
    mailer = Maily::Mailer.find('notifier')
    email  = mailer.find_email('invitation')

    email.required_arguments.should be_present
    email.require_hook?.should be_true
  end

  it "should handle arguments successfully" do
    mailer = Maily::Mailer.find('notifier')
    email  = mailer.find_email('invitation')

    email.arguments.size.should == 1
    expect { email.call }.to_not raise_error
  end
end
