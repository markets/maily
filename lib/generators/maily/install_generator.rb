module Maily
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc 'Maily installation: route and initializer'
      source_root File.expand_path("../../templates", __FILE__)

      def install
        generate_routing
        add_initializer
      end

      private

      def generate_routing
        route "mount Maily::Engine, at: 'maily'"
      end

      def add_initializer
        copy_file 'initializer.rb', 'config/initializers/maily.rb'
      end
    end
  end
end