require 'rails_helper'
require 'json_web_token'

RSpec.describe JsonWebToken do
  describe "self#encode" do
    context "when it receives a payload" do
      let(:payload) {{id: 1}}
      it "returns a properly encoded JWT" do
        expect(JsonWebToken.encode(payload)).to eq("eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MX0.QBb3QzeEGSHUc2LlouQTTCyP9ABwEWebl8rPVlnQKCw")
      end
    end
    context "when it receives no payload" do
      let(:payload) {nil}
      it "returns a no method error" do
        expect {
          JsonWebToken.encode(payload)
        }.to raise_error(NoMethodError)
      end
    end
  end

  describe "self#decode" do
    context "when it receives a valid token" do
      let(:token) {"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MX0.QBb3QzeEGSHUc2LlouQTTCyP9ABwEWebl8rPVlnQKCw"}
      let(:expected_payload) {{"id"=>1}}
      it "returns the payload" do
        expect(JsonWebToken.decode(token)).to eq expected_payload
      end
    end
    context "when it receives no token" do
      let(:token) {nil}
      it "returns nil" do
        expect(JsonWebToken.decode(token)).to be_nil
      end
    end
    context "when it receives a token with an invalid signature" do
      let(:token) {"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MX0.QBb3QzeEGSHUc2LlouQTTCyP9ABwEWebl8rPVlnQKff"}
      it "returns nil" do
        expect(JsonWebToken.decode(token)).to be_nil
      end
    end
  end
end
