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
      expect(good_kele_load.get_token).to be_a(String)
    end

    it "raises an error when a bad username and/or password is given" do
      expect{Kele.new(ENV["FAKE_EMAIL"], ENV["FAKE_PASSWORD"])}.to raise_error(RuntimeError)
    end
  end

  describe "get_token" do
    it "returns a token" do
      expect(good_kele_load.get_token).to_not be_nil
    end

    it "cannot mutate the token instance variable" do
      token = good_kele_load.get_token
      token.swapcase!
      original_token = good_kele_load.get_token
      expect(token).to_not eq(original_token)
    end
  end

  describe "get_me" do
    let(:get_me_results) { good_kele_load.get_me }

    it "returns a Ruby hash" do
      expect(get_me_results).to be_a(Hash)
    end

    it "returns the correct email address" do
      expect(get_me_results["email"]).to eq(ENV["CORRECT_EMAIL"])
    end
  end

  describe "get_mentor_availability" do
    let(:get_mentor_availability_results) { good_kele_load.get_mentor_availability }

    it "returns a Ruby array" do
      expect(get_mentor_availability_results).to be_a(Array)
    end

    it "returns correct information" do
      keys = get_mentor_availability_results.first.keys

      expect(keys.include?('id')).to be_truthy
      expect(keys.include?('starts_at')).to be_truthy
      expect(keys.include?('ends_at')).to be_truthy
      expect(keys.include?('week_day')).to be_truthy
      expect(keys.include?('booked')).to be_truthy
    end
  end

  describe "get_roadmap" do
    let(:get_roadmap_results) { good_kele_load.get_roadmap(31) }

    it "returns a Ruby hash" do
      expect(get_roadmap_results).to be_a(Hash)
    end

    it "returns the roadmap for Rails" do
      expect(get_roadmap_results["short_name"]).to eq("Rails")
    end
  end
end
