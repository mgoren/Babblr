class Message

  define_method(:initialize) do |attributes|
    @to = attributes[:to]
    @post = attributes.fetch(:post)
    @comment = attributes.fetch(:comment)
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
  end

end
