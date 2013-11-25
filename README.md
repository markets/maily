Maily
==============

**[IN PROGRESS: working, but not ready for first release]**

Rails Engine to preview, follow up, test and edit application emails.

## Installation
Add this line to you Gemfile:

```
gem 'maily'
```

Run generator:

```
rails g maily:install
```

This installator mounts the engine:
```
mount Maily::Engine, at: 'maily'
```

And adds an initializer to customize some settings and define hooks.

## Hooks
Hooks are used to collect data for emails:

```ruby
user = User.new(email: 'user@example.com')
comment = Comment.new(body: 'Lorem ipsum')
service = Service.new(price: '100USD')

Maily.hooks_for('Notifier') do |mailer|
  mailer.register_hook(:welcome, user)
  mailer.register_hook(:new_comment, user, comment)
end

Maily.hooks_for('PaymentNotifier') do |mailer|
  mailer.register_hook(:invoice, user, service)
end
```