module Maily
  class Engine < ::Rails::Engine
    isolate_namespace Maily
    load_generators

    config.assets.precompile << %w(
      maily/application.css
      maily/application.js
      maily/logo.png
      maily/icons/*.svg
    )
  end
end