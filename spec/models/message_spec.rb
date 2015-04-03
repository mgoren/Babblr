require 'rails_helper'

describe Message do
  it "sends an sms" do
    msg = Message.new(to: ENV['TO_PHONE_NUMBER'], post: "foo", comment: "bar")
    status = msg.send_sms
    expect(status).to eq("queued")
  end
end