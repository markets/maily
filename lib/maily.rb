require 'maily/engine'
require 'maily/version'
require 'maily/mailer'
require 'maily/email'

module Maily
  class << self

    attr_accessor :enabled, :allow_edition, :allow_delivery, :available_locales, :base_controller

    def init!
      self.enabled           = true
      self.allow_edition     = true
      self.allow_delivery    = true
      self.available_locales = I18n.available_locales
      self.base_controller   = 'ActionController::Base'
    end

    def load_emails_and_hooks
      # Load emails
      Dir[Rails.root + 'app/mailers/*.rb'].each do |mailer|
        klass   = File.basename(mailer, '.rb')
        methods = klass.camelize.constantize.send(:instance_methods, false)
        Maily::Mailer.new(klass, methods)
      end

      # Load hooks
      hooks_file_path = "#{Rails.root}/lib/maily_hooks.rb"
      require hooks_file_path if File.exists?(hooks_file_path)
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
      when :edit, :update
        allow_edition
      when :deliver
        allow_delivery
      end
    end
  end
end