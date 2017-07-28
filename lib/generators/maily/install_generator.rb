module Maily
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc 'Maily installation: route and initializer'
      source_root File.expand_path("../../templates", __FILE__)

      def install
        generate_routing
        build_initializer
        build_hooks
      end

      private

      def generate_routing
        route "mount Maily::Engine, at: '/maily'"
      end

      def build_initializer
        template 'initializer.rb', 'config/initializers/maily.rb'
      end

      def build_hooks
        Maily.init!

        fixtures = []
        hooks    = []

        Maily::Mailer.all.each do |mailer|
          hooks << "\nMaily.hooks_for('#{mailer.name.classify}') do |mailer|"
          mailer.emails.each do |email|
            if email.require_hook?
              fixtures << email.required_arguments
              hooks << "  mailer.register_hook(:#{email.name}, #{email.required_arguments.join(', ')})"
            end
          end
          hooks << "end"
        end

        create_file "lib/maily_hooks.rb" do
          fixtures.flatten.uniq.map{ |f| f = "#{f.to_s} = ''" }.join("\n") + "\n" + hooks.join("\n") + "\n"
        end
      end
    end
  end
end