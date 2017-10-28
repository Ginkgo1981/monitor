namespace :monitor do
  desc 'send_to_slack'
  task alert: :environment do
    puts "[slack-servce] alert begin #{Time.now}"
    res = "\n"
    res += `lsof -i -P -n | grep 3000` ? "Cable  up\n" : "Cable  down\n"
    res += `lsof -i -P -n | grep 4444` ? "Selenium  up\n" : "Selenium  down\n"
    res += `lsof -i -P -n | grep 9200` ? "ElasticSearch  up\n" : "ElasticSearch  down\n"
    res += `lsof -i -P -n | grep 6379` ? "Redis  up\n" : "Redis  down\n"
    res += `lsof -i -P -n | grep 8082` ? "Text-analyzer  up\n" : "Text-analyze  down\n"
    res += `lsof -i -P -n | grep 8000` ? "game  up\n" : "game  down\n"
    res += `lsof -i -P -n | grep 8080` ? "Loop  up\n" : "Loop  down\n"
    enqueued_channels_list =  $redis.llen 'crawler:enqueued_channels_list'
    company_job_json_list = $redis.llen 'crawler:company_job_json_list'
    enqueued_links_list= $redis.llen 'crawler:enqueued_links_list'
    cached_links_url_set = $redis.scard 'crawler:cached_links_url_set'
    res += "enqueued_channels_list: #{enqueued_channels_list}\n"
    res += "enqueued_links_list: #{enqueued_links_list}\n"
    res += "company_job_json_list: #{company_job_json_list}\n"
    res += "cached_links_url_set: #{cached_links_url_set}\n"
    SlackService.alert res
    puts "[slack-servce] alert end #{Time.now}"
  end
end

