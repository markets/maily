module Maily
  class EmailsController < ApplicationController

    def index
      @mailers = Maily::Mailer.all
    end

    def show
      @mailer = Maily::Mailer.find(params[:mailer])
      @email  = @mailer.find_email(params[:method]).render
    end

    def edit
      @email = File.read("#{Rails.root}/app/views/#{params[:mailer]}/#{params[:method]}.html.erb")
    end

    def update
      @email = File.open("#{Rails.root}/app/views/#{params[:mailer]}/#{params[:method]}.html.erb", 'w') do |f|
        f.write(params[:body])
      end

      redirect_to maily_email_path(mailer: params[:mailer], method: params[:method])
    end
  end
end