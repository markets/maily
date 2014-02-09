require 'spec_helper'

describe Maily do
  it "should set up with defaults if no block provided" do
    Maily.setup

    Maily.enabled.should be_true
    Maily.allow_edition.should be_true
    Maily.allow_delivery.should be_true
    Maily.available_locales.should == I18n.available_locales
    Maily.base_controller.should == 'ActionController::Base'
  end

  it "should not allow edition if edition is disabled" do
    Maily.allow_edition = false

    Maily.allowed_action?(:edit).should be_false
    Maily.allowed_action?(:update).should be_false
  end

  it "should not allow delivery if delivery is disabled" do
    Maily.allow_delivery = false

    Maily.allowed_action?(:deliver).should be_false
  end
end
