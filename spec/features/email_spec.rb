require 'spec_helper'

describe "Maily::Email" do
  it "should load emails" do
    mailer = Maily::Mailer.find('notifier')
    mailer.emails.size.should == 1
  end

  it "should not require hook if method does not have arguments" do
    mailer = Maily::Mailer.find('notifier')
    email  = mailer.find_email('welcome')

    email.require_hook?.should be_false
  end
end
