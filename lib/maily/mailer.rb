module Maily
  class Mailer
    cattr_accessor :collection
    attr_accessor :name, :emails

    def initialize(name, methods)
      self.collection ||= []
      self.name       = name
      self.emails     = self.class.build_emails(methods, name)
      self.collection << self
    end

    def self.all
      Maily.load_emails_and_hooks if collection.nil?
      collection
    end

    def self.find(mailer_name)
      all.find { |mailer| mailer.name == mailer_name }
    end

    def self.build_emails(methods, mailer)
      methods.map do |email|
        Maily::Email.new(email, mailer)
      end
    end

    def register_hook(email_name, *args)
      email = find_email(email_name)
      email.register_hook(args)
    end

    def find_email(email_name)
      emails.find { |email| email.name == email_name.to_s }
    end
  end
end