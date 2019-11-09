module Maily
  module Generator
    def self.run
      Maily.init!

      fixtures = []
      hooks    = []

      Maily::Mailer.list.each do |mailer|
        _hooks = []

        mailer.emails_list.each do |email|
          if email.require_hook?
            fixtures << email.required_arguments
            _hooks << "  mailer.register_hook(:#{email.name}, #{email.required_arguments.join(', ')})"
          end
        end

        if _hooks.present?
          hooks << "\nMaily.hooks_for('#{mailer.name.classify}') do |mailer|"
          hooks << _hooks
          hooks << "end"
        end
      end

      fixtures = fixtures.flatten.uniq.map do |fixture|
        argument = fixture.to_s
        value = argument.pluralize == argument ? '[]' : "''"

        [argument, value].join(' = ')
      end.join("\n")

      hooks    = hooks.join("\n")

      fixtures + "\n" + hooks + "\n"
    end
  end
end
