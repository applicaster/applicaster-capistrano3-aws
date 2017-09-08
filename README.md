# Capistrano3::Aws

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'applicaster-capistrano3-aws', require: false
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install applicaster-capistrano3-aws


## Usage

in `Capfile`:

```ruby
require 'capistrano3/aws'
include Capistrano3::Aws
```


in `config/deploy.rb`:

```ruby
set :ssm_params_prefix, -> { "/environments/#{fetch(:stage)}/services/#{fetch(:application)}/deployment" }
set :aws_region, "us-east-1"
```

in `config/deploy/production.rb`:

```ruby
servers = ec2_instances([{ name: 'tag:ApplicationName', values: ["encoder"] }], :private_ip_address)) # or :public_dns_name or :public_ip_address
role :app, servers
role :web, ec2_instances([{ name: 'tag:Name', values: ["encoder-web"] }], :private_ip_address)
role :encoders, ec2_instances([{ name: 'tag:Name', values: ["encoder-ffmpeg"] }], :private_ip_address))
role :db, servers.first, primary: true
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/applicaster/applicaster-capistrano3-aws.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

