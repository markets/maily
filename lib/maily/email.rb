module Maily
  class Email

    attr_accessor :name, :mailer, :has_hook, :arguments

    def initialize(name, mailer)
      self.name      = name
      self.mailer    = mailer
      self.has_hook  = false
      self.arguments = nil
    end

    def require_hook?
      mailer_klass.instance_method(name).parameters.any?
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

    def render
      mailer_klass.send(name, *arguments)
    end
  end
end
