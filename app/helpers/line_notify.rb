# /camera/app/helpers/line_notify.rb

module LineNotify
  def self.post_message(message)
    uri = URI.parse("https://notify-api.line.me/api/notify")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri.request_uri)
    request["Authorization"] = "Bearer #{ENV['LINE_API_TOKEN']}"
    request.set_form_data({"message" => message})

    response = http.request(request)
    return response.is_a?(Net::HTTPSuccess)
  end
end