module Maily
  module EmailsHelper
    def total_emails(mailers)
      mailers.map { |mailer| mailer.total_emails }.sum
    end

    def email_description(email)
      return unless email.description

      content_tag(:div, class: 'mail_description') do
        concat content_tag(:strong, 'Description ')
        concat email.description
      end
    end

    def part_class(part)
      'format_selected' if (part == params[:part]) || (part == 'html' && !params[:part])
    end
  end
end
