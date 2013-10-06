module Maily
  class Email

    attr_accessor :name, :mailer, :hook

    def initialize(name, mailer)
      self.name   = name
      self.mailer = mailer
      self.hook   = nil
    end

    def require_hook?
      mailer_klass.constantize.instance_method(name).parameters.any?
    end

    def register_hook(&block)
      self.hook = block
    end

    def mailer_klass
      mailer.camelize
    end

    def render
      if hook
        hook.call
      else
        mailer_klass.constantize.send(name)
      end
    end
  end
end
