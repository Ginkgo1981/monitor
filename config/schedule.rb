env :PATH, ENV['PATH']

set :output, '/mnt/log/loop-alert.log'
set :bundle_command, '/usr/local/bin/bundle exec'
set :job_template, nil

every 30.minute do
  rake 'monitor:alert'
end
