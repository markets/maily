module Maily
  class ApplicationController < Maily.base_controller.constantize
    before_action :maily_enabled?, :http_authorization

    layout 'maily/application'

    def maily_params
      _params = {}

      [:mailer, :email, :version, :part, :locale, :version].each do |key|
        _params[key] = params[key] if params[key].present?
      end

      _params
    end
    helper_method :maily_params

    private

    def maily_enabled?
      Maily.enabled || head(404, message: "Maily disabled")
    end

    def http_authorization
      if auth_hash = Maily.http_authorization
        authenticate_or_request_with_http_basic do |username, password|
          username == auth_hash[:username] && password == auth_hash[:password]
        end
      end
    end
  end
end
