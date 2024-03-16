# app/services/line_notification.rb

require 'line/bot'

module Line
  module Bot
    class Client
      def initialize
        # implementation
      end
    end
  end
end

class LineNotification
  def self.send_message(message)
    client = Line::Bot::Client.new { |config|
      config.channel_secret = ENV['LINE_CHANNEL_SECRET']
      config.channel_token = ENV['LINE_CHANNEL_TOKEN']
    }

    message = {
      type: 'text',
      text: message
    }

    response = client.push_message(ENV['LINE_USER_ID'], message)
    puts response.body if response.is_a?(Net::HTTPSuccess)
  end
end
