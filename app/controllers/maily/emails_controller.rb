module Maily
  class EmailsController < Maily::ApplicationController
    before_action :allowed_action?, only: [:edit, :update, :deliver]
    before_action :load_mailers, only: [:index, :show, :edit]
    before_action :load_mailer_and_email, except: [:index]
    around_action :perform_with_locale, only: [:show, :raw, :deliver]

    def index
    end

    def show
      valid, message = @maily_email.validate_arguments

      unless valid
        redirect_to(root_path, alert: message)
      end
    end

    def raw
      content = if @email.multipart?
        params[:part] == 'text' ? @email.text_part.body : @email.html_part.body
      else
        @email.body
      end

      content = content.raw_source
      content = view_context.simple_format(content) if @email.sub_type == 'plain' || params[:part] == 'text'
      content = prepare_inline_attachments(@email, content)

      render html: content.html_safe, layout: false
    end

    def attachment
      attachment = @email.attachments.find { |elem| elem.filename == params[:attachment] }

      send_data attachment.body, filename: attachment.filename, type: attachment.content_type
    end

    def edit
      @template = @maily_email.template(params[:part])
    end

    def update
      @maily_email.update_template(params[:body], params[:part])

      redirect_to maily_email_path(mailer: params[:mailer], email: params[:email], part: params[:part]), notice: 'Template updated!'
    end

    def deliver
      @email.to = params[:to]

      @email.deliver

      redirect_to maily_email_path(mailer: params[:mailer], email: params[:email]), notice: "Email sent to <b>#{params[:to]}</b>!"
    end

    private

    def allowed_action?
      Maily.allowed_action?(action_name) || redirect_to(root_path, alert: "Action <b>#{action_name}</b> not allowed!")
    end

    def load_mailers
      @mailers = Maily::Mailer.list
    end

    def load_mailer_and_email
      mailer = Maily::Mailer.find(params[:mailer])
      @maily_email = mailer.find_email(params[:email])

      if @maily_email
        @email = @maily_email.call
      else
        redirect_to(root_path, alert: "Email not found!")
      end
    end

    def perform_with_locale
      I18n.with_locale(params[:locale]) do
        yield
      end
    end

    def prepare_inline_attachments(email, content)
      content.gsub(/src=(?:"cid:[^"]+"|'cid:[^']+')/i) do |match|
        if part = find_part(email, match[9..-2])
          %[src="data:#{part.mime_type};base64,#{Base64.encode64(part.body.raw_source)}"]
        else
          match
        end
      end
    end

    def find_part(email, cid)
      email.all_parts.find { |p| p.attachment? && p.cid == cid }
    end
  end
end
