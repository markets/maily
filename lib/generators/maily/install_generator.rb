module Maily
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc 'Maily installation: route and initializer'
      source_root File.expand_path("../../templates", __FILE__)

      def install
        generate_routing
        build_initializer
      end

      private

      def generate_routing
        route "mount Maily::Engine, at: 'maily'"
      end

      def build_initializer
        template 'initializer.rb', 'config/initializers/maily.rb'

        hooks = []
        fixtures = []

        Maily::Mailer.all.each do |mailer|
          hooks << "# Maily.hooks_for('#{mailer.name.classify}') do |mailer|"
          mailer.emails.each do |email|
            if email.require_hook?
              fixtures << email.required_arguments
              hooks << "#   mailer.register_hook(:#{email.name}, #{email.required_arguments.join(', ')})"
            end
          end
          hooks << "# end\n"
        end

        inject_into_file "config/initializers/maily.rb", after: "end\n" do
          "\n" + fixtures.flatten.uniq.map{ |f| f = "# #{f.to_s} = ''" }.join("\n") +
          "\n" + hooks.join("\n")
        end

      end
    end
  end
end