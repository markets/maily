module Maily
  class EmailsController < ApplicationController

    def index
      @mailers = Maily.mailers
    end

    def show
      mailer = params[:mailer].camelize
      hook = "Maily::#{mailer}Hook".constantize

      @email = if hook.send(:new).respond_to?(params[:method])
        hook.send(:new).send(params[:method])
      else
        mailer.constantize.send(params[:method])
      end

      @email_raw = File.read("#{Rails.root}/app/views/#{params[:mailer]}/#{params[:method]}.html.erb")
    end
  end
end
