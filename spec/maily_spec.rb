require 'spec_helper'

describe Maily do
  it "should initialize with some defaults if no block is provided" do
    Maily.setup

    expect(Maily.enabled).to be true
    expect(Maily.allow_edition).to be true
    expect(Maily.allow_delivery).to be true
    expect(Maily.available_locales).to eq(I18n.available_locales)
    expect(Maily.base_controller).to eq('ActionController::Base')
    expect(Maily.http_authorization).to be nil
  end

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
