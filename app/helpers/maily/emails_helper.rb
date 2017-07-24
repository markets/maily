module Maily
  module EmailsHelper
    def total_emails(mailers)
      mailers.map { |mailer| mailer.emails.size }.sum
    end

    def part_class(part)
      'format_selected' if (part == params[:part]) || (part == 'html' && !params[:part])
    end
  end
end
