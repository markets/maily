Maily.init!

# Maily.setup do |maily|
#   maily.allowed_environments << :production
# end

<% Maily::Mailer.all.each do |mailer| %>
  Maily::Mailer.define_hooks_for('<%= mailer.name %>') do |mailer|
    <% mailer.emails.each do |email| %>
      <% if email.require_hook? %>
        mailer.register_hook(:<%= email.name %>, <%= email.required_arguments.join(', ') %>)
      <% end %>
    <% end %>
  end
<% end %>
