module Capistrano
  module Aws
    module_function

    def ec2
      @ec2 ||= ::Aws::EC2::Client.new(region: fetch(:aws_region))
    end

    def ssm
      @ssm ||= ::Aws::SSM::Client.new(region: fetch(:aws_region))
    end
  end
end