class Notifier < ApplicationMailer
  def no_arguments
    mail
  end

  def with_arguments(email, opt_arg = nil)
    mail
  end

  def with_array_arguments(emails)
    mail
  end

  def with_params
    @message = params[:message]
    mail
  end

  def custom_template_path(email)
    mail template_path: 'notifications'
  end

  def custom_template_name
    mail template_name: 'custom_template'
  end

  def hidden
    mail
  end

  def multipart
    mail
  end

  def only_text
    mail
  end

  def with_slim_template
    mail
  end

  def with_inline_attachments
    attachments.inline['image.jpg'] = File.read(Rails.root.join("public/favicon.ico"))
    mail
  end

  def version(account)
    @account = account
    mail
  end
end
