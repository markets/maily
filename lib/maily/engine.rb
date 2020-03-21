module Maily
  class Engine < ::Rails::Engine
    isolate_namespace Maily
    load_generators

    config.assets.precompile << %w(
      maily/application.css
      maily/logo.png
      maily/icons/globe.svg
      maily/icons/paperclip.svg
    )
  end
end
