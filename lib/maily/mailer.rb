module Maily
  class Mailer
    cattr_accessor :collection
    attr_accessor :name, :emails, :klass

    def initialize(name)
      self.name   = name
      self.klass  = name.camelize.constantize
      self.emails = {}

      parse_emails

      self.class.collection ||= {}
      self.class.collection[name] = self
    end

    def self.all
      Maily.load_emails_and_hooks if collection.nil?
      collection
    end

    def self.find(mailer_name)
      all[mailer_name]
    end

    def find_email(email_name)
      emails[email_name.to_s]
    end

    def total_emails
      emails.size
    end

    def register_hook(email_name, *args)
      email = find_email(email_name)
      email && email.register_hook(args)
    end

    def hide_email(*email_names)
      email_names.each do |email_name|
        emails.delete(email_name.to_s)
      end
    end

    private

    def parse_emails
      _emails = klass.send(:public_instance_methods, false)

      _emails.map(&:to_s).each do |email|
        self.emails[email] = Maily::Email.new(email, self)
      end
    end
  end
end