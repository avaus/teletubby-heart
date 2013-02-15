require 'spec_helper'

describe Ckeditor do
  describe Ckeditor::Picture do
    before(:each) do

    end
    it "has valid url" do
      visit "/"
      response.should == '404'
    end
  end
  describe Ckeditor::AttachmentFile do
    before(:each) do
    end
    it "has valid url" do
      visit "/"
      response.should == '404'
    end
  end
end