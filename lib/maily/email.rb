module Maily
  class Email
    attr_accessor :name, :mailer, :arguments, :template_path

    def initialize(name, mailer)
      self.name          = name.to_s
      self.mailer        = mailer
      self.arguments     = nil
      self.template_path = mailer
    end

    def parameters
      mailer_klass.instance_method(name).parameters
    end

    def require_hook?
      parameters.any?
    end

    def required_arguments
      parameters.map(&:last)
    end

    def correct_number_of_arguments?
      required_arguments.size == arguments.size
    end

    def register_hook(*args)
      args = args.flatten

      if args.last.is_a?(Hash) && new_path = args.last.delete(:template_path)
        self.template_path = new_path
        args.pop
      end

      self.arguments = args
    end

    def mailer_klass_name
      mailer.camelize
    end

    def mailer_klass
      mailer_klass_name.constantize
    end

    def call
      *args = arguments && arguments.map { |arg| arg.respond_to?(:call) ? arg.call : arg }

      if args == [nil]
        mailer_klass.send(name)
      else
        mailer_klass.send(name, *args)
      end
    end

    def base_path(part)
      "#{Rails.root}/app/views/#{template_path}/#{name}.#{part}.erb"
    end

    def path(part = nil)
      if part
        base_path(part)
      else
        if File.exist?(path('html'))
          base_path('html')
        else
          base_path('text')
        end
      end
    end

    def template(part = nil)
      File.read(path(part))
    end

    def update_template(new_content, part = nil)
      File.open(path(part), 'w') do |f|
        f.write(new_content)
      end
    end
  end
end