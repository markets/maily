module Maily
  class ApplicationController < Maily.base_controller.constantize

    before_filter :maily_enabled?

    layout 'maily/application'

    private

    def maily_enabled?
      Maily.enabled || raise('Maily: engine disabled!')
    end
  end
end
