require 'maily/engine'
require 'maily/version'
require 'maily/mailer'
require 'maily/email'

module Maily
  class << self

    attr_accessor :allowed_environments

    def init!
      self.allowed_environments = [:development, :test]
      build_mailers
    end

    def build_mailers
      Dir[Rails.root + 'app/mailers/*.rb'].each do |mailer|
        klass   = File.basename(mailer, '.rb')
        methods = klass.camelize.constantize.send(:instance_methods, false)
        Maily::Mailer.new(klass, methods)
      end
    end

    def setup
      yield(self)
    end

    def allowed_env?(env)
      allowed_environments.include?(env.to_sym)
    end
  end
end