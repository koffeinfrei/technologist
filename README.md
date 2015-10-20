# Technologist

This library detects the technologies used in a repository.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'technologist'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install technologist

## Usage

```
require 'technologist'

technologist = Technologist.new('.')
technologist.primary_framework      # => ['Dashing']
technologist.secondary_framework    # => ['Sinatra']
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

To add a framework definition just add it to the
[frameworks.yml](lib/technologist/frameworks.yml) file.

1. Fork it ( https://github.com/[my-github-username]/technologist/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
