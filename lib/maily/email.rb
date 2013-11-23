module Maily
  class Email

    attr_accessor :name, :mailer, :arguments

    def initialize(name, mailer)
      self.name      = name.to_s
      self.mailer    = mailer
      self.arguments = nil
    end

    def require_hook?
      mailer_klass.instance_method(name).parameters.any?
    end

    def required_arguments
      mailer_klass.instance_method(name).parameters.map(&:last)
    end

    def register_hook(*args)
      self.arguments = args.flatten
    end

    def mailer_klass_name
      mailer.camelize
    end

    def mailer_klass
      mailer_klass_name.constantize
    end

    def call
      mailer_klass.send(name, *arguments)
    end
  end
end
