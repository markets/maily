RSpec.describe Maily::Email do
  let(:mailer) { Maily::Mailer.find('notifier') }

  context "with no arguments" do
    let (:email) { mailer.find_email('no_arguments') }

    it "should not require hook" do
      expect(email.required_arguments).to be_blank
      expect(email.require_hook?).to be false
    end

    it ".call" do
      expect { email.call }.to_not raise_error
    end
  end

  context "with arguments" do
    let (:email) { mailer.find_email('with_arguments') }

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

    it 'should handle array type arguments' do
      email = mailer.find_email('with_array_arguments')

      expect(email.arguments.first).to be_an(Array)
      expect(email.arguments.size).to eq(email.required_arguments.size)
    end

    it ".call" do
      expect { email.call }.to_not raise_error
    end
  end

  context "with params" do
    let (:email) { mailer.find_email('with_params') }

    it "should not require hook" do
      expect(email.required_arguments).to be_blank
      expect(email.require_hook?).to be false
    end

    it 'should handle lazy params successfully' do
      expect(email.with_params).to be_present
      expect { email.call }.to_not raise_error
    end

    it 'should handle not lazy arguments successfully' do
      allow(email).to receive(:message).and_return('Hello!')

      expect(email.with_params).to be_present
      expect { email.call }.to_not raise_error
    end
  end

  it "should handle template_path via hook" do
    email = mailer.find_email('custom_template_path')

    expect(email.template_path).to eq('notifications')
  end

  it "should handle template_name via hook" do
    email = mailer.find_email('custom_template_name')

    expect(email.template_name).to eq('custom_template')
  end

  it "should handle description via hook" do
    email = mailer.find_email('with_description')

    expect(email.description).to eq('description')
  end

  describe '#validate_arguments' do
    it 'emails with no arguments required' do
      email = mailer.find_email('no_arguments')
      expect(email.validate_arguments).to eq [true, nil]

      email.arguments = ["asd"]
      expect(email.validate_arguments[1]).to match(/email requires at the most 0 arguments, passed 1/)
    end

    it 'emails with arguments required' do
      email = mailer.find_email('with_arguments')
      expect(email.validate_arguments).to eq [true, nil]

      email = mailer.find_email('custom_template_path')
      expect(email.validate_arguments[1]).to match(/email requires at least 1 arguments, passed 0/)
    end
  end

  describe '#path' do
    it 'with a multipart email defaults to html' do
      email = mailer.find_email('multipart')

      expect(email.path).to include('multipart.html.erb')
      expect(email.path('text')).to include('multipart.text.erb')
      expect(email.path('foo')).to eq nil
    end

    it 'with other template engines (e.g. Slim)' do
      email = mailer.find_email('with_slim_template')

      expect(email.path).to include('with_slim_template.html.slim')
    end
  end

  context 'class methods' do
    describe '#name_with_version' do
      it 'without version' do
        expect(Maily::Email.name_with_version('welcome', nil)).to eq("welcome:#{Maily::Email::DEFAULT_VERSION}")
      end

      it 'with version' do
        expect(Maily::Email.name_with_version('welcome', 'first_version')).to eq('welcome:first_version')
      end
    end

    describe '#formatted_version' do
      it 'without version' do
        expect(Maily::Email.formatted_version(nil)).to eq(Maily::Email.formatted_version(Maily::Email::DEFAULT_VERSION))
      end

      it 'with version' do
        expect(Maily::Email.formatted_version('First Version')).to eq('first_version')
      end
    end
  end
end
