require 'spec_helper'

# from http://developer.apple.com/library/ios/#documentation/AppleApplications/Reference/SafariWebContent/OptimizingforSafarioniPhone/OptimizingforSafarioniPhone.html
IPHONE_USER_AGNET = "Mozilla/5.0 (iPhone; U; CPU iOS 2_0 like Mac OS X; en-us) AppleWebKit/525.18.1 (KHTML, like Gecko) Version/3.1.1 Mobile/XXXXX Safari/525.20"

def use_iphone
  # depends on defualt driver Capybara::RackTest::Driver
  page.driver.header("USER_AGENT", IPHONE_USER_AGNET)
end

describe "View Template Overriding" do
  context "Action view template" do
    it "renders mobile template when client is a mobile device" do
      use_iphone

      visit "/pages/action_view"

      page.should have_selector('#mobile-view')
    end

    it "renders default template when client is not a mobile device" do
      visit "/pages/action_view"

      page.should have_selector('#default-view')
    end
  end

  context "Overriding partial view template" do
    it "renders mobile template when client is a mobile device" do
      use_iphone

      visit "/pages/partial_view"

      page.should have_selector('#mobile-partial-view')
    end

    it "renders default template when client is not a mobile device" do
      visit "/pages/partial_view"

      page.should have_selector('#default-partial-view')
    end
  end

  context "Overriding layout view template" do
    it "renders mobile layout template when client is a mobile device" do
      use_iphone

      visit "/pages/default"

      page.should have_selector('body.mobile')
    end

    it "renders default layout template when client is not a mobile device" do
      visit "/pages/default"

      page.should have_selector('body.desktop')
    end
  end

  context "Not overriding" do
    it "renders default template when client is a mobile device" do
      use_iphone

      visit "/pages/default"

      page.should have_selector('#hello-world')
    end

    it "renders default template when client is not a mobile device" do
      visit "/pages/default"

      page.should have_selector('#hello-world')
    end
  end
end

describe "mobile_device? usage" do
  it "renders mobile-specific content when client is a mobile device" do
    use_iphone

    visit "/pages/conditional"

    page.should have_selector('#mobile-device')
    page.should have_content('Hi Mobile!')
  end

  it "renders general content when client is not a mobile device" do
    visit "/pages/conditional"

    page.should have_selector('#non-mobile-device')
    page.should have_content('Hi Desktop!')
  end
end