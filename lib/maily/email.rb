module Maily
  class Email
    attr_accessor :name, :mailer, :arguments, :template_path, :template_name, :description

    def initialize(name, mailer)
      self.name          = name
      self.mailer        = mailer
      self.arguments     = nil
      self.template_path = mailer.name
      self.template_name = name
      self.description   = nil
    end

    def mailer_klass
      mailer.klass
    end

    def parameters
      mailer_klass.instance_method(name).parameters
    end

    def require_hook?
      parameters.any?
    end

    def required_arguments
      parameters.select { |param| param.first == :req }.map(&:last)
    end

    def optional_arguments
      parameters.select { |param| param.first == :opt }.map(&:last)
    end

    def validate_arguments
      from = required_arguments.size
      to = from + optional_arguments.size
      passed_by_hook = arguments && arguments.size || 0

      if passed_by_hook < from
        [false, "#{name} email requires at least #{from} arguments, passed #{passed_by_hook}"]
      elsif passed_by_hook > to
        [false, "#{name} email requires at the most #{to} arguments, passed #{passed_by_hook}"]
      else
        [true, nil]
      end
    end

    def register_hook(*args)
      args = args.flatten

      if args.last.is_a?(Hash)
        self.description = args.last.delete(:description)

        if tpl_path = args.last.delete(:template_path)
          self.template_path = tpl_path
        end

        if tpl_name = args.last.delete(:template_name)
          self.template_name = tpl_name
        end

        args.pop
      end

      self.arguments = args
    end

    def call
      *args = arguments && arguments.map { |arg| arg.respond_to?(:call) ? arg.call : arg }

      if args == [nil]
        mailer_klass.public_send(name)
      else
        mailer_klass.public_send(name, *args)
      end
    end

    def base_path(part)
      Dir["#{Rails.root}/app/views/#{template_path}/#{template_name}.#{part}.*"].first
    end

    def path(part = nil)
      return base_path(part) if part

      html_part = base_path('html')
      if html_part && File.exist?(html_part)
        html_part
      else
        base_path('text')
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