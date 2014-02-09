require 'spec_helper'

describe "Maily::Mailer" do
  it "should load mailers" do
    Maily::Mailer.all.size.should == 1
  end

  it "should find mailers by name" do
    Maily::Mailer.find('notifier').name.should == 'notifier'
  end

  it "should find emails by name" do
    mailer = Maily::Mailer.find('notifier')
    mailer.find_email('welcome').name.should == 'welcome'
  end
end
