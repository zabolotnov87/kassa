# Kassa

Ruby Client Library for working with [Yandex Kassa](https://kassa.yandex.ru).

NOTE: current implementation does not support ALL features, and includes only:

  * Create Payment
  * Get Payment Status
  * Receiving Callback From Payment Gate

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'kassa'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kassa

## Configuration

```ruby
Kassa.configure do |config|
  config.api_endpoint = 'https://payment.yandex.net/api/v3/'
  config.account_id = ENV['ACCOUNT_ID']
  config.secret_key = ENV['SECRET_KEY']
  config.logger = Logger.new(STDERR)
end
```

or

```ruby
client = Kassa::Client.new(
  api_endpoint: 'https://payment.yandex.net/api/v3/',
  account_id: ENV['ACCOUNT_ID'],
  secret_key: ENV['SECRET_KEY'],
  logger: Logger.new(STDERR),
)
```

The last example preferred in case when your work with several merchants.

## Usage

### Create Payment

```ruby
request = Kassa::Requests::Payment.new.tap do |payment|
  payment.amount = { value: 2999, currency: 'RUB' }
  payment.confirmation = { type: :redirect, return_url: 'https://example.com' }
end

payment = Kassa.client.create_payment(request, idempotence_key: SecureRandom.uuid)
```

### Get Payment Status

```ruby
Kassa.client.payment('some payment id')
```

### Receiving Callback From Payment Gate

First, create a callback application:

```ruby
KassaWebhooksApp = Kassa::Webhooks::App.new do |notification|
  Rails.logger.info(notification)
end
```

Then mount your callback application:

```ruby
# config/routes.rb
Rails.application.routes.draw do
  mount KassaWebhooksApp, at: '/webhooks/kassa'
end
```

## Development

Setup:

```console
make setup
```

Run linters:

```console
make lint
```

Run tests:

```console
make test
```

Publish gem to nexus:

```console
make publish
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/zabolotnov87/kassa. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Test project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/zabolotnov87/kassa/blob/master/CODE_OF_CONDUCT.md).
