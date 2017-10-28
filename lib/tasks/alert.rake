namespace :loop do
  desc 'alert when LOOP production NOT works well'
  task alert: :environment do
    puts "[slack-servce] alert begin #{Time.now}"
    #unicorn
    res_unicorn = `ps aux | grep unicorn | grep -v grep`
    SlackService.alert 'HI, Unicorn was Down, Please check Unicorn' unless res_unicorn.include? 'unicorn'
    #redis
    res_redis = `ps aux | grep redis-server | grep -v grep`
    SlackService.alert 'HI, Redis was Down, Please check Redis' unless res_redis.include? 'redis-server'
    #sidekiq
    res_sidekiq = `ps aux | grep sidekiq | grep -v grep`
    SlackService.alert 'HI, Sidekiq was Down, Please check Sidekiq' unless res_sidekiq.include? 'sidekiq'
    #queue
    high_queue_count = $redis.llen 'queue:high'
    default_queue_count = $redis.llen 'queue:default'
    pass_queue_count = $redis.llen 'queue:pass_push'
    if high_queue_count > 10 || default_queue_count >15 || pass_queue_count > 20
      SlackService.alert 'HI, There are too many Backlog in Redis, Please check Redis and Sidekiq'
    end
    puts "[slack-servce] alert end #{Time.now}"
  end
end

