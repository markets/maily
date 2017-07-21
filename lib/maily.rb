require 'maily/engine'
require 'maily/version'
require 'maily/mailer'
require 'maily/email'

module Maily
  class << self
    attr_accessor :enabled, :allow_edition, :allow_delivery, :available_locales,
                  :base_controller, :http_authorization, :hooks_path

    def init!
      self.enabled            = Rails.env.production? ? false : true
      self.allow_edition      = Rails.env.production? ? false : true
      self.allow_delivery     = Rails.env.production? ? false : true
      self.available_locales  = I18n.available_locales
      self.base_controller    = 'ActionController::Base'
      self.http_authorization = nil
      self.hooks_path         = "lib/maily_hooks.rb"
    end

    def load_emails_and_hooks
      # Load emails from file system
      Dir[Rails.root + 'app/mailers/*.rb'].each do |mailer|
        klass_name = File.basename(mailer, '.rb')
        klass = klass_name.camelize.constantize
        methods = klass.send(:public_instance_methods, false)
        Maily::Mailer.new(klass_name, methods)
      end

      # Load hooks
      hooks_file_path = File.join(Rails.root, hooks_path)
      require hooks_file_path if File.exist?(hooks_file_path)
    end

    def hooks_for(mailer_name)
      mailer = Maily::Mailer.find(mailer_name.underscore)
      yield(mailer) if block_given?
    end

    def setup
      init!
      yield(self) if block_given?
    end

    def allowed_action?(action)
      case action.to_sym
      when :edit
        allow_edition
      when :update
        allow_edition && !Rails.env.production?
      when :deliver
        allow_delivery
      end
    end
  end
end
