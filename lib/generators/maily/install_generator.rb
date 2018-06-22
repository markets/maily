module Maily
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc 'Maily installation: route and initializer'
      source_root File.expand_path("../../templates", __FILE__)

      def install
        puts 'Installing Maily ...'
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
        create_file "lib/maily_hooks.rb" do
          Maily::Generator.run
        end
      end
    end
  end
end