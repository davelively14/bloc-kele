require 'spec_helper'

RSpec.describe Kele do
  let(:good_kele_load) { Kele.new(ENV["CORRECT_EMAIL"], ENV["CORRECT_PASSWORD"]) }

  describe "rspec config" do
    it "loads environmental variables" do
      expect(ENV["TEST"]).to eq('test_string')
    end
  end

  describe "new" do
    it "creates an authorization token" do
      expect(good_kele_load.get_token).to_not be_nil
    end

    it "raises an error when a bad username and/or password is given" do
      expect{Kele.new(ENV["FAKE_EMAIL"], ENV["FAKE_PASSWORD"])}.to raise_error(RuntimeError)
    end
  end
end
