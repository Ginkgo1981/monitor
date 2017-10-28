class SlackService
  def self.alert text
    url = 'https://hooks.slack.com/services/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'
    payload = {
        text: text
    }
    res = Faraday.post url,JSON.generate(payload)
    puts "[SlackService] alert res: #{res.body}"
  end
end