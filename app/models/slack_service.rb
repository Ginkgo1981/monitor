class SlackService
  def self.alert text
    url = 'https://hooks.slack.com/services/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' #play
    payload = {
        text: "#{Time.now.to_s} - #{text}"
    }
    res = Faraday.post url,JSON.generate(payload)
    puts "[SlackService] monitor res: #{res.body}"
  end
end