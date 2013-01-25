require 'spec_helper'

describe DashboardController do

  describe "Pagination" do
    it "Should be disabled if no following channels" do
      get :home, {page: 1}
      assigns(:pagination_next).should be_false
      assigns(:pagination_prev).should be_false
    end
    it "Should assign next if more than 4 channels" do
      6.times do
        Channel.create!(name: "TestChannel")
      end
      get :home, {page: 1}
      assigns(:pagination_next).should be_true
      assigns(:pagination_prev).should be_false
      get :home, {page: 2}
      assigns(:pagination_next).should be_false
      assigns(:pagination_prev).should be_true
    end
  end
end
