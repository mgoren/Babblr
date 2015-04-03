class Message

  def initialize(attributes)
    @to = attributes[:to]
    @post = attributes[:post]
    @comment = attributes[:comment]
    @body = "Your post (" + @post + ") has received the following response: " + @comment
  end

  def send_sms
    begin
      response = RestClient::Request.new(
        method: :post,
        url: "https://api.twilio.com/2010-04-01/Accounts/#{ENV['TWILIO_ACCOUNT_SID']}/Messages.json",
        user: ENV['TWILIO_ACCOUNT_SID'],
        password: ENV['TWILIO_AUTH_TOKEN'],
        payload: { Body: @body, To: @to, From: ENV['FROM_PHONE_NUMBER'] }
      ).execute
    rescue RestClient::BadRequest => error
      message = JSON.parse(error.response)['message']
      errors.add(:base, message)
      false
    end
    parsed_response = JSON.parse(response)
    status = parsed_response['status']
    return status
  end

  def self.get_last_sms
    response = RestClient::Request.new(
      method: :get,
      url: "https://api.twilio.com/2010-04-01/Accounts/#{ENV['TWILIO_ACCOUNT_SID']}/Messages.json",
      user: ENV['TWILIO_ACCOUNT_SID'],
      password: ENV['TWILIO_AUTH_TOKEN'],
    ).execute
    parsed_response = JSON.parse(response)
    messages_data = parsed_response['messages']
    return messages_data.first
  end

end
