require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'
require 'mina/rails'
require 'mina/rvm'
# require 'mina/whenever'

set :domain, '139.224.65.151'
set :application, 'monitor'
set :user, 'deploy'
set :deploy_to, "/home/#{user}/apps/#{application}"
set :repository, 'git@github.com:Ginkgo1981/monitor.git'
set :branch, 'master'

set :rvm_path, '/usr/share/rvm/bin/rvm'
task :environment do
  invoke :'rvm:use[ruby-2.3.1@default]'
end

set :shared_paths, ['config/database.yml', 'config/secrets.yml', 'log']
task setup: :environment do

  if repository
    repo_host = repository.split(%r{@|://}).last.split(%r{:|\/}).first
    repo_port = /:([0-9]+)/.match(repository) && /:([0-9]+)/.match(repository)[1] || '22'

    queue %[
      if ! ssh-keygen -H  -F #{repo_host} &>/dev/null; then
        ssh-keyscan -t rsa -p #{repo_port} -H #{repo_host} >> ~/.ssh/known_hosts
      fi
    ]
  end
end

desc "Deploys the current version to the server."
task deploy: :environment do
  to :before_hook do
    # Put things to run locally before ssh
  end

  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    # invoke :'whenever:update'
    invoke :'deploy:cleanup'
    to :launch do
    end
  end
end

