module Maily
  class EmailsController < ApplicationController

    before_filter :allowed_action?, only: [:edit, :update, :deliver]
    before_filter :load_mailer_and_email, except: [:index, :edit, :update]
    around_filter :perform_with_locale, only: [:show, :raw, :deliver]

    def index
      @mailers = Maily::Mailer.all
    end

    def show
      @mailers = Maily::Mailer.all
    end

    def raw
      content = if @email.parts.present?
        params[:part] == 'text' ? @email.text_part.body : @email.html_part.body
      else
        @email.body
      end

      render text: content, layout: false
    end

    def attachment
      attachment = @email.attachments.find { |elem| elem.filename == params[:attachment] }
      send_data attachment.body, filename: attachment.filename, type: attachment.content_type
    end

    def edit
      @mailers = Maily::Mailer.all
      @email = File.read("#{Rails.root}/app/views/#{params[:mailer]}/#{params[:method]}.html.erb")
    end

    def update
      @email = File.open("#{Rails.root}/app/views/#{params[:mailer]}/#{params[:method]}.html.erb", 'w') do |f|
        f.write(params[:body])
      end

      redirect_to maily_email_path(mailer: params[:mailer], method: params[:method])
    end

    def deliver
      @email.to = params[:to]

      @email.deliver

      redirect_to maily_email_path(mailer: params[:mailer], method: params[:method])
    end

    private

    def allowed_action?
      Maily.allowed_action?(action_name) || raise("Maily: action #{action_name} not allowed!")
    end

    def load_mailer_and_email
      @mailer = Maily::Mailer.find(params[:mailer])
      @email = @mailer.find_email(params[:method]).call
    end

    def perform_with_locale
      I18n.with_locale(params[:locale]) do
        yield
      end
    end
  end
end
