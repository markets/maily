module Maily
  module EmailsHelper
    def total_emails(mailers)
      mailers.map { |mailer| mailer.total_emails }.sum
    end

    def email_description(email)
      return unless email.description

      tag.div(class: 'mail_description') do
        concat tag.strong('Description ')
        concat email.description
      end
    end

    def part_class(part)
      'format_selected' if part == params[:part] || (part == 'html' && !params[:part])
    end

    def uniq_emails(email_list)
      email_list.inject([]) do |memo, email|
        memo << email unless memo.map(&:name).include?(email.name)
        memo
      end
    end
  end
end
