# Maily

[![Gem Version](https://badge.fury.io/rb/maily.svg)](http://badge.fury.io/rb/maily)
[![Build Status](https://travis-ci.org/markets/maily.svg?branch=master)](https://travis-ci.org/markets/maily)
[![Maintainability](https://api.codeclimate.com/v1/badges/fff01b2137fd73070b14/maintainability)](https://codeclimate.com/github/markets/maily/maintainability)

Maily is a Rails Engine to manage, test and navigate through all your email templates of your app, being able to preview them directly in your browser.

Maily automatically picks up all your emails and make them accessible from a kind of dashboard.

## Features:

* Mountable engine
* Visual preview in the browser (attachments as well)
* Template edition (only in development)
* Email delivery
* Features configurables per environment
* Flexible authorization system
* Minimalistic and clean interface
* Easy way (aka `hooks`) to define and customize data for emails
* Generator to handle a comfortable installation

![](screenshot.png)

## Installation

Add this line to you Gemfile:

```
gem 'maily'
```

Run generator:

```
rails g maily:install
```

This generator runs some tasks for you:

* Mounts the engine (to `/maily` by default) in your routes
* Adds an initializer (into `config/initializers/maily.rb`) to customize some settings
* Adds a file (into `lib/maily_hooks.rb`) to define hooks

## Initialization and configuration

You should configure Maily via the initializer. You can set these options per environment:

```ruby
Maily.enabled = ENV['MAILY_ENABLED']

Maily.enabled = Rails.env.production? ? false : true
```

Initializer sample (full options list):

 ```ruby
# config/initializers/maily.rb
Maily.setup do |config|
  # On/off engine
  # config.enabled = Rails.env.production? ? false : true

  # Allow templates edition
  # config.allow_edition = Rails.env.production? ? false : true

  # Allow deliveries
  # config.allow_delivery = Rails.env.production? ? false : true

  # Your application available_locales (or I18n.available_locales) by default
  # config.available_locales = [:en, :es, :pt, :fr]

  # Run maily under different controller ('ActionController::Base' by default)
  # config.base_controller = '::AdminController'

  # Configure hooks path
  # config.hooks_path = 'lib/maily_hooks.rb'

  # Http basic authentication (nil by default)
  # config.http_authorization = { username: 'admin', password: 'secret' }

  # Customize welcome message
  # config.welcome_message = "Welcome to our email testing platform. If you have any problem, please contact support team at support@example.com."
end
```

### Templates edition (`allow_edition` option)

This feature was designed for `development` environment. Since it's just a file edition and running in `production`, code is not reloaded between requests, Rails doesn't take in account this change (without restarting the server). Also, allow arbitrary ruby code evaluation is potentially dangerous, that's not a good idea for `production`.

So, template edition is not allowed outside of `development` environment.

## Hooks

Most of emails need to populate some data to consume it and do interesting things. Hooks are used to define this data with a little DSL. Hooks accept "callable" objects to lazy load (most expensive) data. Example:

```ruby
# lib/maily_hooks.rb
user = User.new(email: 'user@example.com')
lazy_user = -> { User.with_comments.first } # callable object, lazy evaluation
comment = Struct.new(:body).new('Lorem ipsum') # stub way
service = FactoryGirl.create(:service) # using fixtures with FactoryGirl

Maily.hooks_for('Notifier') do |mailer|
  mailer.register_hook(:welcome, user, template_path: 'users')
  mailer.register_hook(:new_comment, lazy_user, comment)
end

Maily.hooks_for('PaymentNotifier') do |mailer|
  mailer.register_hook(:invoice, user, service)
end
```

Note that you are able to override the `template_path` and the `template_name` like can be done in Rails. You must pass these options as a hash and last argument:

```ruby
Maily.hooks_for('YourMailerClass') do |mailer|
  mailer.register_hook(:a_random_email, template_path: 'notifications')
  mailer.register_hook(:another_email, template_name: 'email_base')
end
```

### Email description

You can add a description to any email and it will be displayed along with its preview. This is useful in some cases like: someone from another team, for example, a marketing specialist, visiting Maily to review some texts and images; they can easily understand when this email is sent by the system.

```ruby
Maily.hooks_for('BookingNotifier') do |mailer|
  mailer.register_hook(:accepted, description: "This email is sent when a reservation has been accepted by the system." )
end
```

### Hide emails

You are also able to hide emails:

```ruby
Maily.hooks_for('Notifier') do |mailer|
  mailer.hide_email(:sensible_email, :secret_email)
end
```

## Authorization

Basically, you have 2 ways to restrict the access to `Maily`.

### Custom base controller

By default `Maily` runs under `ActionController::Base`, but you are able to customize that parent controller (`Maily.base_controller` option) in order to achieve (using, for example, `before_action` blocks) a kind of access control system. For example, set a different base controller:

```ruby
Maily.base_controller = '::SuperAdminController'
```

And then write your own authorization rules in this defined controller:

```ruby
class SuperAdminController < ActionController::Base
  before_action :maily_authorized?

  private

  def maily_authorized?
    current_user.admin? || raise("You don't have access to this section!")
  end
end
```

### HTTP basic authentication

You can also authorize yours users via HTTP basic authentication, simply use this option:

```ruby
Maily.http_authorization = { username: 'admin', password: 'secret' }
```

## Notes

Rails 4.1 introduced a built-in mechanism to preview the application emails. It is in fact a port of [basecamp/mail_view](https://github.com/basecamp/mail_view) gem to the core.

Alternatively, there are some other plugins to get a similar functionality with different approaches and options. For example, [ryanb/letter_opener](https://github.com/ryanb/letter_opener), [sj26/mailcatcher](https://github.com/sj26/mailcatcher) or [glebm/rails_email_preview](https://github.com/glebm/rails_email_preview).

## Development

Any kind of feedback, bug report, idea or enhancement are really appreciated :tada:

To contribute, just fork the repo, hack on it and send a pull request. Don't forget to add specs for behaviour changes and run the test suite:

    > bundle exec appraisal rake

## License

Copyright (c) Marc Anguera. Maily is released under the [MIT](MIT-LICENSE) License.
