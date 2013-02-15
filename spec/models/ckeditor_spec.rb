require 'spec_helper'

describe Ckeditor do
  describe Ckeditor::Picture do
    it "has valid url_content" do
      ck = Ckeditor::Picture.new
      ck.url_content.should == "/data/content/missing.png"
    end
  end
  describe Ckeditor::AttachmentFile do
    it "has valid url_thumb" do
      ck = Ckeditor::AttachmentFile.new
      ck.url_thumb.should == "/assets/ckeditor/filebrowser/images/thumbs/unknown.gif"
    end
  end
end