module Maily
  class EmailsController < ApplicationController

    layout 'maily/application'

    def index
      @emails = Notifier.instance_methods(false)
    end

    def show
      @email = Notifier.send(params[:id])
      @email_raw = File.read("#{Rails.root}/app/views/notifier/#{params[:id]}.html.erb")
    end
  end
end
