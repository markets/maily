module Maily
  module ApplicationHelper
    def title
      _title = 'Maily'

      if params[:mailer] && params[:email]
        _title << " - #{params[:mailer].humanize} | #{params[:email].humanize}"
      end

      _title
    end

    def sidebar_class(mailer, email)
      'selected_mail' if mailer.name == params[:mailer] && email.name == params[:email]
    end

    def logo
      image_tag(file_to_base64('maily/logo.png', 'image/png'))
    end

    def icon(name)
      image_tag(file_to_base64("maily/icons/#{name}.svg", 'image/svg+xml'), class: :icon)
    end

    private

    def file_to_base64(path, mime_type)
      file = Maily::Engine.root.join('app/assets/images').join(path)
      base64_contents = Base64.strict_encode64(file.read)

      "data:#{mime_type};base64,#{base64_contents}"
    end
  end
end
