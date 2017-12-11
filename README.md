# sidekiq-dirty-exit

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sidekiq-dirty-exit'
```

And then execute:

    $ bundle

## NOTE

This gem changes some internal functionality of sidekiq that might break pro and enterprise
setups. So I would not recommend using it on those scenarios. And you probably
dont need to, the use for this gem is not needed if you have reliable queueing.

## Usage

No need to do anything just adding the gem will enable dirty exit tracking.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/sidekiq-dirty-exit. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the sidekiq-dirty-exit project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/sidekiq-dirty-exit/blob/master/CODE_OF_CONDUCT.md).
