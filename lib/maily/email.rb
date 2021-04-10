module Maily
  class Email
    DEFAULT_VERSION = 'default'.freeze

    attr_accessor :name, :mailer, :arguments, :template_path, :template_name, :description, :with_params, :version

    class << self
      def name_with_version(name, version = nil)
        _version = formatted_version(version)
        [name, _version].join(':')
      end

      def formatted_version(version)
        _version = version.presence || DEFAULT_VERSION
        _version&.parameterize&.underscore
      end
    end

    def initialize(name, mailer)
      self.name          = name
      self.mailer        = mailer
      self.arguments     = nil
      self.with_params   = nil
      self.template_path = mailer.name
      self.template_name = name
      self.description   = nil
    end

    def mailer_klass
      mailer.klass
    end

    def parameterized_mailer_klass
      params = with_params && with_params.transform_values { |param| param.respond_to?(:call) ? param.call : param }
      mailer_klass.with(params)
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
      if args.last.is_a?(Hash)
        self.description = args.last.delete(:description)
        self.with_params = args.last.delete(:with_params)
        self.version = Maily::Email.formatted_version(args.last.delete(:version))

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
        parameterized_mailer_klass.public_send(name)
      else
        parameterized_mailer_klass.public_send(name, *args)
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

    def versions
      regexp = Regexp.new("^#{self.name}:")

      mailer.emails.select do |email_key, _email|
        email_key.match?(regexp)
      end
    end

    def has_versions?
      versions.count > 1
    end
  end
end
