module Maily
  module ApplicationHelper
    def sidebar_class(mailer, email)
      'maily_selected_mail' if mailer.name == params[:mailer] && email.name == params[:email]
    end
  end
end
