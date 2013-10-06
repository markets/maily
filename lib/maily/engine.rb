module Maily
  class Engine < ::Rails::Engine
    isolate_namespace Maily
    load_generators
  end
end
