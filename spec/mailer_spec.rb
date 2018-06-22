require 'spec_helper'

describe Maily::Mailer do
  it "should load mailers" do
    expect(Maily::Mailer.all.keys).to eq(['notifier'])
  end

  it "should build emails" do
    mailer = Maily::Mailer.find('notifier')

    expect(mailer.emails.size).to eq(6)
  end

  it "should find mailers by name" do
    expect(Maily::Mailer.find('notifier').name).to eq('notifier')
  end

  it "should find emails by name" do
    mailer = Maily::Mailer.find('notifier')

    expect(mailer.find_email('welcome').name).to eq('welcome')
  end

  it "allows to hide email" do
    mailer = Maily::Mailer.find('notifier')

    expect(mailer.find_email('hidden')).to be nil
  end

  it ".list returns an array with all mailers" do
    list = Maily::Mailer.list

    expect(list).to be_an_instance_of(Array)
    expect(list.sample).to be_an_instance_of(Maily::Mailer)
  end

  it "#emails_list returns an array with all emails" do
    mailer = Maily::Mailer.find('notifier')

    expect(mailer.emails_list).to be_an_instance_of(Array)
    expect(mailer.emails_list.sample).to be_an_instance_of(Maily::Email)
  end
end
