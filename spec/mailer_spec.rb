RSpec.describe Maily::Mailer do
  let(:mailer) { Maily::Mailer.find('notifier') }

  it "should load mailers" do
    expect(Maily::Mailer.all.keys).to include('application_mailer', 'notifier')
  end

  it "should build emails" do
    expect(mailer.emails.size).to eq(12)
  end

  it "should find mailers by name" do
    expect(Maily::Mailer.find('notifier').name).to eq('notifier')
  end

  it "should find emails by name" do
    expect(mailer.find_email('welcome').name).to eq('welcome')
  end

  it "allow to add inherited emails via a hook" do
    expect(mailer.find_email('generic_welcome').name).to eq('generic_welcome')
  end

  it "allows to hide email" do
    expect(mailer.find_email('hidden')).to be nil
  end

  it ".list returns an array with all mailers" do
    list = Maily::Mailer.list

    expect(list).to be_an_instance_of(Array)
    expect(list.sample).to be_an_instance_of(Maily::Mailer)
  end

  it "#emails_list returns an array with all emails" do
    expect(mailer.emails_list).to be_an_instance_of(Array)
    expect(mailer.emails_list.sample).to be_an_instance_of(Maily::Email)
  end
end
