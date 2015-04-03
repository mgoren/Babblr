require 'rails_helper'

describe Message, vcr: true do
  it "sends an sms" do
    msg = Message.new(to: ENV['TO_PHONE_NUMBER'], body: "hello, world.")
    response = msg.send_sms
    parsed_response = JSON.parse(response)
    expect(parsed_response['status']).to eq("queued")
  end
end