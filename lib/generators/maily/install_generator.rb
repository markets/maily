module Maily
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Add engine route to config/routes.rb"

      def generate_routing
        route "mount Maily::Engine, at: 'maily'"
      end
    end
  end
end