require 'spec_helper'

# from http://developer.apple.com/library/ios/#documentation/AppleApplications/Reference/SafariWebContent/OptimizingforSafarioniPhone/OptimizingforSafarioniPhone.html
IPHONE_USER_AGNET = "Mozilla/5.0 (iPhone; U; CPU iOS 2_0 like Mac OS X; en-us) AppleWebKit/525.18.1 (KHTML, like Gecko) Version/3.1.1 Mobile/XXXXX Safari/525.20"

def use_iphone
  # depends on poltergeist
  page.driver.headers = { "User-Agent" => IPHONE_USER_AGNET }
end

def set_mobile_cookie
  # depends on poltergeist
  page.driver.set_cookie "mobile", "1"
end

describe "View Template Overriding" do
  context "when client is mobile device" do
    before :each do
      use_iphone
    end

    it "renders mobile-specific action view template" do
      visit "/pages/action_view"

      page.should have_selector('#mobile-view')
    end

    it "renders mobile-specific partial view template" do
      visit "/pages/partial_view"

      page.should have_selector('#mobile-partial-view')
    end

    it "renders mobile-specific layout view template" do
      visit "/pages/layout_template"

      page.should have_selector('body.mobile')
    end

    it "renders default view template when there is no mobile-specific overriding" do
      visit "/pages/default"

      page.should have_selector('#hello-world')
    end

    it "renders mobile-specific content" do
      visit "/pages/conditional"

      page.should have_selector('#mobile-device')
      page.should have_content('Hi Mobile!')
    end
  end

  context "when client provides mobile cookie" do
    before :each do
      set_mobile_cookie
    end

    it "renders mobile-specific action view template" do
      visit "/pages/action_view"

      page.should have_selector('#mobile-view')
    end

    it "renders mobile-specific partial view template" do
      visit "/pages/partial_view"

      page.should have_selector('#mobile-partial-view')
    end

    it "renders mobile-specific layout view template" do
      visit "/pages/layout_template"

      page.should have_selector('body.mobile')
    end

    it "renders default view template when there is no mobile-specific overriding" do
      visit "/pages/default"

      page.should have_selector('#hello-world')
    end

    it "renders mobile-specific content" do
      visit "/pages/conditional"

      page.should have_selector('#mobile-device')
      page.should have_content('Hi Mobile!')
    end
  end

  context "when client is not mobile browser" do
    it "renders default action view template" do
      visit "/pages/action_view"

      page.should have_selector('#default-view')
    end

    it "renders default partial view template" do
      visit "/pages/partial_view"

      page.should have_selector('#default-partial-view')
    end

    it "renders default layout view template" do
      visit "/pages/layout_template"

      page.should have_selector('body.desktop')
    end

    it "renders default view template when there is no mobile-specific overriding" do
      visit "/pages/default"

      page.should have_selector('#hello-world')
    end

    it "renders general content" do
      visit "/pages/conditional"

      page.should have_selector('#non-mobile-device')
      page.should have_content('Hi Desktop!')
    end
  end
end
