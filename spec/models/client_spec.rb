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
    it "should set deleted_at timestamp when destroyed" do
      client = Client.new
      client.save
      client.destroy
      client.should be_valid
      client.deleted_at.should_not be_nil
    end
  end
  
end
