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

    def template_path(part = nil)
      if part
        "#{Rails.root}/app/views/#{mailer}/#{name}.#{part}.erb"
      else
        find_template
      end
    end

    def find_template
      if File.exist?("#{Rails.root}/app/views/#{mailer}/#{name}.html.erb")
        "#{Rails.root}/app/views/#{mailer}/#{name}.html.erb"
      else
        "#{Rails.root}/app/views/#{mailer}/#{name}.text.erb"
      end
    end

    def template(part = nil)
      File.read(template_path(part))
    end

    def update_template(new_content, part = nil)
      File.open(template_path(part), 'w') do |f|
        f.write(new_content)
      end
    end
  end
end
