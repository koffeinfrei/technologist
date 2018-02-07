[![Gem Version](https://badge.fury.io/rb/technologist.svg)](https://badge.fury.io/rb/technologist)
[![Build Status](https://travis-ci.org/koffeinfrei/technologist.svg?branch=master)](https://travis-ci.org/koffeinfrei/technologist)

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

```ruby
require 'technologist'

technologist = Technologist::Repository.new('.')
technologist.primary_frameworks      # => ['Sinatra']
technologist.secondary_frameworks    # => ['Dashing']
technologist.frameworks              # => ['Sinatra', 'Dashing']
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release` to create a git tag for the version, push git
commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

To add a framework definition add a new section to the
[frameworks.yml](lib/technologist/frameworks.yml) file and
add a new spec covering the new framework in [spec/frameworks_rules_spec.rb](spec/frameworks_rules_spec.rb)

1. Fork it ( https://github.com/koffeinfrei/technologist/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License

This program is free software: you can redistribute it and/or modify it under
the terms of the [Lesser GNU General Public License](LICENSE) as published by
the Free Software Foundation, either version 3 of the License, or (at your
option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.  See the Lesser GNU General Public License for more
details.

**You can use this gem in proprietary and commercial projects. The LGPL only
demands that you contribute back changes to the library itself.**
