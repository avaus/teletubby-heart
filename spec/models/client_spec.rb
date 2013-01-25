require 'spec_helper'

describe Client do
  describe "creation" do
    it "should create new client" do
      client = Client.create!
      client.reload
      client.should be_valid
    end
  end

  describe "client" do
    it "should be marked as active before 300 seconds of inactivity" do
      client = Client.new
      client.save
      client.last_slide_change = Time.now - 299
      client.active?.should be_true
    end
    it "should be marked as inactive after 300 seconds of inactivity" do
      client = Client.new
      client.save
      client.last_slide_change = Time.now - 301
      client.active?.should be_false
    end
  end

  describe "deletion" do
    it "should remove the client entry from database" do
      client = Client.new
      client.save
      expect { client.destroy }.to change(Client, :count).by(-1)
    end
  end
  
end
