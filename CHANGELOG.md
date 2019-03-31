# Changelog

All notable changes to this project will be documented in this file.

## [0.9.1]

- Properly display text parts by respecting break lines
- CI: official Rails 6 support
- Reduce gem size by including only necessary files

## [0.9.0]

- Allow to register external mailers, for example, from a gem
- CI Rubies: add 2.6 and drop 2.2 (EOL)

## [0.8.2]

- Fix incompatibility with last gem `mail` (v2.7.1) release (#32)

## [0.8.1]

- Serve fonts from Google Fonts API

## [0.8.0]

- Inherited emails support (#28)
- `Maily.available_locales` defaults to Rails available_locales `config.i18n.available_locales` (#27)

## [0.7.2]

- Definitive fix for newer apps using `webpacker` and without `sass-rails` (#22)
- Fix regression in generator, from v0.7.0 (#24)
- Allow to edit emails with different templates engines: Slim, Haml, ... (#25)

## [0.7.1]

- Fix assets pipeline integration for applications using `webpacker` instead of `sprockets` (#22)

## [0.7.0]

- Allow to hide emails (#11)
- Allow to override `template_name`
- New project logo
- Internal classes refactor
- Front-end cleanup and simplification (remove font icons, update normalize.css, CSS/HTML refactor, better page titles, better flash messages)
- Drop Ruby 2.1 (EOL) from CI
- CI against Rails 5.2

## [0.6.3]

- Add support for `reply_to`

## [0.6.2]

- Rails 5.1 fixes (#19, #20)
- Hooks: improve arguments validation (#20)

## [0.6.1]

- Fix Rails automatic generator (#18)
- UI: display better error messages (#17)
- UI: alphabetically sort mailers and emails in sidebar (#17)

## [0.6.0]

- Lazy hooks (#14)
- Better capture and dispatch internal exceptions (#13)
- Allow to define a description per email (#10)
- Remove HTML5 Shiv (front-end dependency)
- Fix assets pipeline integration
- Lots of front-end tweaks
- Basic dashboard with customizable welcome message
- CI suite: officially supported Rails versions: 4.2, 5.0 and 5.1

## [0.5.0]

- Appraisals integration: Rails 3.2, 4.X and 5.0
- Modernize CI Rubies: add 2.2, 2.3 and 2.4 (remove 1.9.3 and 2.0)
- Fix Ruby warnings (#12)
- Docs typos (#8)

## [0.4.0]

- Allow to setup HTTP basic authentication

## [0.3.5]

- CI: run tests against ruby 2.1
- Properly define dependencies

## [0.3.4]

- Fix syntax error introduced in v0.3.3 :(

## [0.3.3]

- Disallow templates edition in production mode

## [0.3.2]

- Fix #3: email container not displayed properly in Firefox

## [0.3.1]

- Add basic specs
- CI integration

## [0.3.0]

- First real usable release :tada:

[0.9.1]: https://github.com/markets/maily/compare/v0.9.0...v0.9.1
[0.9.0]: https://github.com/markets/maily/compare/v0.8.2...v0.9.0
[0.8.2]: https://github.com/markets/maily/compare/v0.8.1...v0.8.2
[0.8.1]: https://github.com/markets/maily/compare/v0.8.0...v0.8.1
[0.8.0]: https://github.com/markets/maily/compare/v0.7.2...v0.8.0
[0.7.2]: https://github.com/markets/maily/compare/v0.7.1...v0.7.2
[0.7.1]: https://github.com/markets/maily/compare/v0.7.0...v0.7.1
[0.7.0]: https://github.com/markets/maily/compare/v0.6.3...v0.7.0
[0.6.3]: https://github.com/markets/maily/compare/v0.6.2...v0.6.3
[0.6.2]: https://github.com/markets/maily/compare/v0.6.1...v0.6.2
[0.6.1]: https://github.com/markets/maily/compare/v0.6.0...v0.6.1
[0.6.0]: https://github.com/markets/maily/compare/v0.5.0...v0.6.0
[0.5.0]: https://github.com/markets/maily/compare/v0.4.0...v0.5.0
[0.4.0]: https://github.com/markets/maily/compare/v0.4.0...v0.5.0
[0.3.5]: https://github.com/markets/maily/compare/v0.3.5...v0.4.0
[0.3.4]: https://github.com/markets/maily/compare/v0.3.3...v0.3.4
[0.3.3]: https://github.com/markets/maily/compare/v0.3.2...v0.3.3
[0.3.2]: https://github.com/markets/maily/compare/v0.3.1...v0.3.2
[0.3.1]: https://github.com/markets/maily/compare/v0.3.0...v0.3.1
[0.3.0]: https://github.com/markets/maily/compare/v0.1.0...v0.3.0
