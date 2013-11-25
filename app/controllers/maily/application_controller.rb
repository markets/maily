module Maily
  class ApplicationController < Maily.base_controller.constantize

    before_filter :allowed_environment?

    layout 'maily/application'

    private

    def allowed_environment?
      Maily.allowed_env?(Rails.env) || raise("Not allowed environment #{Rails.env}")
    end
  end
end
