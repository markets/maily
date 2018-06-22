module Maily
  module Generator
    def self.run
      Maily.init!

      fixtures = []
      hooks    = []

      Maily::Mailer.list.each do |mailer|
        hooks << "\nMaily.hooks_for('#{mailer.name.classify}') do |mailer|"
        mailer.emails_list.each do |email|
          if email.require_hook?
            fixtures << email.required_arguments
            hooks << "  mailer.register_hook(:#{email.name}, #{email.required_arguments.join(', ')})"
          end
        end
        hooks << "end"
      end

      fixtures = fixtures.flatten.uniq.map { |f| "#{f.to_s} = ''" }.join("\n")
      hooks    = hooks.join("\n")

      fixtures + "\n" + hooks + "\n"
    end
  end
end