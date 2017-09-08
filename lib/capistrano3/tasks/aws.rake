namespace :load do
  task :defaults do
    set :ssm_params_prefix, -> { "/environments/#{fetch(:stage)}/services/#{fetch(:application)}/deployment" }
    set :aws_region, "us-east-1"
  end
end

namespace :deploy do
  desc "Updates AWS SSM parameters with latest revision and release_slug attributes"
  task :update_ssm_parameters do
    if fetch(:stage) === :production
      current_revision = nil
      release_name = fetch(:release_timestamp)

      on roles(:db) do
        within "#{fetch(:repo_path)}" do
          current_revision = capture(:git, "rev-parse #{fetch(:branch)}")
        end
      end

      update_ssm_parameter("#{fetch(:ssm_params_prefix)}/revision", current_revision)
      update_ssm_parameter("#{fetch(:ssm_params_prefix)}/release_slug", release_name)
      puts "UPDATED:: AWS SSM parameters to REVISION: #{current_revision}, RELEASE: #{release_name}"    
    end
  end
end

after "deploy", "deploy:update_ssm_parameters"