module Capistrano3
  module Aws
    module Client
      module_function

      def ec2
        @ec2 ||= ::Aws::EC2::Client.new(region: fetch(:aws_region, ENV["AWS_REGION"]))
      end

      def ssm
        @ssm ||= ::Aws::SSM::Client.new(region: fetch(:aws_region, ENV["AWS_REGION"]))
      end
    end
  end
end