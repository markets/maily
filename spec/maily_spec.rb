require 'spec_helper'

describe "Maily" do
  it "default configuration" do
    Maily.setup

    Maily.enabled.should be_true
    Maily.allow_edition.should be_true
    Maily.allow_delivery.should be_true
    Maily.available_locales.should == I18n.available_locales
    Maily.base_controller.should == 'ActionController::Base'
  end
end
