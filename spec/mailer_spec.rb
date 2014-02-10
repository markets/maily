require 'spec_helper'

describe Maily::Mailer do
  it "should load mailers" do
    expect(Maily::Mailer.all.size).to eq(1)
  end

  it "should build emails" do
    mailer = Maily::Mailer.find('notifier')
    expect(mailer.emails.size).to eq(3)
  end

  it "should find mailers by name" do
    expect(Maily::Mailer.find('notifier').name).to eq('notifier')
  end

  it "should find emails by name" do
    mailer = Maily::Mailer.find('notifier')
    expect(mailer.find_email('welcome').name).to eq('welcome')
  end
end
