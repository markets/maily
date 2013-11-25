require 'maily/engine'
require 'maily/version'
require 'maily/mailer'
require 'maily/email'

module Maily
  class << self

    attr_accessor :allowed_environments, :available_locales, :base_controller

    def init!
      self.allowed_environments = [:development]
      self.available_locales    = I18n.available_locales
      self.base_controller      = 'ActionController::Base'
    end

    def build_emails
      Dir[Rails.root + 'app/mailers/*.rb'].each do |mailer|
        klass   = File.basename(mailer, '.rb')
        methods = klass.camelize.constantize.send(:instance_methods, false)
        Maily::Mailer.new(klass, methods)
      end
    end

    def hooks_for(mailer_name)
      mailer = Maily::Mailer.find(mailer_name.underscore)
      yield(mailer) if block_given?
    end

    def setup
      yield(self)
    end

    def allowed_env?(env)
      allowed_environments.include?(env.to_sym)
    end
  end
end