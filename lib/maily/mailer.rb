module Maily
  class Mailer

    cattr_accessor :collection
    attr_accessor :name, :emails

    def initialize(name, emails)
      self.collection ||= []
      self.name       = name
      self.emails     = self.class.build_emails(emails, name)
      self.collection << self
    end

    def self.all
      collection
    end

    def self.find(mailer_name)
      collection.detect { |mailer| mailer.name == mailer_name }
    end

    def self.build_emails(emails, mailer)
      emails.map do |email|
        Maily::Email.new(email, mailer)
      end
    end

    def self.define_hooks_for(mailer_name)
      mailer = find(mailer_name)
      yield(mailer) if block_given?
    end

    def register_hook(email_name, *args)
      email = find_email(email_name)
      email.register_hook(args)
    end

    def find_email(email_name)
      emails.detect { |email| email.name == email_name.to_sym }
    end
  end
end
