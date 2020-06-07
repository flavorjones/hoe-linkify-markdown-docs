# Hoe::Markdown

Hoe::Markdown is a [Hoe](https://www.zenspider.com/projects/hoe.html) plugin to help manage your project's markdown files. It's intended for gem maintainers, but the underlying library of markdown manipulation methods might be generally useful.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hoe-markdown'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install hoe-markdown


## Usage

In your Rakefile:

``` ruby
Hoe::plugin :markdown
```

Rake tasks are exposed under the `markdown` namespace.


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/flavorjones/hoe-markdown. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/flavorjones/hoe-markdown/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT). See [LICENSE.txt](https://github.com/flavorjones/hoe-markdown/blob/master/LICENSE.txt).


## Code of Conduct

Everyone interacting in the Hoe::Markdown project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/flavorjones/hoe-markdown/blob/master/CODE_OF_CONDUCT.md).
