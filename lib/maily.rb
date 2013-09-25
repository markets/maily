require 'maily/engine'
require 'maily/version'

module Maily
  def self.mailers
    {}.tap do |mailers|
      Dir[Rails.root + 'app/mailers/*.rb'].each do |mailer|
        klass = File.basename(mailer, '.rb')
        mailers[klass] = klass.camelize.constantize.send(:instance_methods, false)
      end
    end
  end
end
