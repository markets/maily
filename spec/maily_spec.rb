require 'spec_helper'

describe Maily do
  it "#setup should initialize with some defaults if no block is provided" do
    Maily.setup

    expect(Maily.enabled).to be true
    expect(Maily.allow_edition).to be true
    expect(Maily.allow_delivery).to be true
    expect(Maily.available_locales).to eq([:en, :es, :pt, :fr])
    expect(Maily.base_controller).to eq('ActionController::Base')
    expect(Maily.http_authorization).to be nil
    expect(Maily.welcome_message).to be nil
  end

  describe '#allowed_action?' do
    it "should not allow edition if edition is disabled" do
      Maily.allow_edition = false

      expect(Maily.allowed_action?(:edit)).to be false
      expect(Maily.allowed_action?(:update)).to be false
    end

    it "should not allow delivery if delivery is disabled" do
      Maily.allow_delivery = false

      expect(Maily.allowed_action?(:deliver)).to be false
    end
  end

  describe '#hooks_for' do
    it "allows to register external hooks" do
      class ExternalMailer < ActionMailer::Base
        def external_email
        end
      end

      Maily.hooks_for('ExternalMailer')

      expect(Maily::Mailer.find('external_mailer').emails.count).to eq 1
    end
  end
end
