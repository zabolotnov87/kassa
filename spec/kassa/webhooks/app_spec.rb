require 'spec_helper'

RSpec.describe Kassa::Webhooks::App do
  include Rack::Test::Methods

  let(:app) { described_class.new(logger, &process_notification) }
  let(:logger) { double('logger', debug: nil, error: nil) }
  let(:payment_id) { '22d6d597-000f-5000-9000-145f6df21d6f' }

  let(:params) do
    {
      'type' => 'notification',
      'event' => 'payment.succeeded',
      'object' => {
        'id' => payment_id,
      },
    }
  end

  def perform_request
    header 'Content-Type', 'application/json'
    post '/', params.to_json
  end

  let(:process_notification) do
    lambda do |notification|
      expect(notification.object_id).to eq payment_id
      expect(notification.payment?).to eq true
      expect(notification.succeeded?).to eq true
    end
  end

  it 'receive and process incoming notification' do
    perform_request
    expect(last_response.status).to eq 200
    expect(last_response.body).to eq 'OK'
  end
end
