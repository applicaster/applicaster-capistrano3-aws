require "aws-sdk"
require "capistrano3/aws/version"
require "capistrano3/aws/client"

load File.expand_path("../tasks/aws.rake", __FILE__)

module Capistrano3
  module Aws
    def ec2_instances(filters, map_attribute = :private_ip_address)
      filters = filters.push({ name: 'instance-state-name', values: %w(running) })
      ec2.describe_instances(filters: filters)
        .reservations
        .map(&:instances)
        .map(&:first)
        .map(&map_attribute)
    end

    def update_ssm_parameter(name, value)
      ssm.put_parameter({
        name: name,
        value: value,
        type: "String",
        overwrite: true,
      })
    end
  end
end