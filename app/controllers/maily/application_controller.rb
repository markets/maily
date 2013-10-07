module Maily
  class ApplicationController < ActionController::Base

    before_filter :allowed_environment?

    layout 'maily/application'

    private

    def allowed_environment?
      Maily.allowed_env?(Rails.env) || raise("Not allowed environment #{Rails.env}")
    end
  end
end
