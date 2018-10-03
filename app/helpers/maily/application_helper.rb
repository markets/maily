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
      'selected_mail' if mailer.name == params[:mailer] && email.key == params[:email]
    end

    def icon(name)
      image_tag "maily/icons/#{name}.svg", class: 'icon'
    end
  end
end
