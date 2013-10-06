module Maily
  class EmailsController < ApplicationController

    def index
      @mailers = Maily::Mailer.all
    end

    def show
      @mailer = Maily::Mailer.find(params[:mailer])
      @email  = @mailer.find_email(params[:method]).render
    end

    def raw
      @email = File.read("#{Rails.root}/app/views/#{params[:mailer]}/#{params[:method]}.html.erb")
    end

  end
end