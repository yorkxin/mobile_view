# MobileView

Easily specify mobile-specific view template for mobile devices in Rails application.

## Installation

Add this line to your application's Gemfile:

    gem "mobile_view", "~> 0.2.0"

And then execute:

    $ bundle

## Dependency

  * Rails 3.2.x

## Usage

### `action.mobile.html.erb` View Template

#### Scenario

You have a view template for `posts#show`, with many DOM elements and JavaScripts, which is good for desktop, but painful for mobile devices. You're tired of `<%= render_something if mobile? %>` conditional hell. You want to make it mobile-friendly, with a view that is mostly different and built form scratch.

#### Solution

Add `posts/show.mobile.html.erb` along with `posts/show.html.erb`. If the browser is a mobile device, then Rails will choose the mobile template first.

It works for any format handlers (`erb`, `haml` etc.) and formats (`json`, `js`, `xml` etc.) available in your Rails application. You just have to add `mobile` after the view's name.

It also works for partial views. When a mobile version of partial view is not available, it will choose non-mobile version automatically. You just have to add `mobile` after the view's name.

It also works for layout view. So you can now use `views/layouts/application.mobile.html.erb` for mobile devices.

### `mobile?` Helper

Still want to detect mobile device in Controller and View? Use `mobile?` helper. It returns `true` if it thinks the browser is a mobile device, `false` otherwise.

To use `mobile?` helper in a mounted engine, for example, [Rails Cell](https://github.com/apotonick/cells), simply include the `MobileView::ControllerAdditions` module:

```ruby
class PostCell < Cell::Rails
  include MobileView::ControllerAdditions
end
```

## Cookie-based Mobile View Switching

By setting `mobile` cookie, you can force it to load mobile views. This is helpful when debugging the app in desktop browsers, or allowing user to switch to mobile version manually.

Example:

```ruby
class AppliactionController < ActionController::Base
  before_filter :manual_mobile_switching

  protected
  # Detects `_mobile_view` parameter.
  # If it is any value other than 0, turn on mobile view,
  # otherwise, turn off mobile view.
  def manual_mobile_switching
    mobile_view_option = params[:_mobile_view]

    if mobile_view_option
      if mobile_view_options == "1"
        cookies["mobile"] = true # or anything other than falsy value
      elsif mobile_view_option == "0"
        cookies.delete "mobile" # remove `mobile' cookie
      end
    end
  end
end
```

## Known Issues

### iPad / Tablets → Mobile View

According to the algorithm of [Rack::MobileDetect](https://github.com/talison/rack-mobile-detect/), iPad will be seen as a Mobile Device. This may be a fail assumption if you want to show your desktop website to iPad and tablet users. This can (may) be resolved by replacing mobile device detection logic or add more tablet-specific methods.

## References

* [#269 Template Inheritance - RailsCasts](http://railscasts.com/episodes/269-template-inheritance)
* [#397 Action View Walkthrough (pro) - RailsCasts](http://railscasts.com/episodes/397-action-view-walkthrough)
* [Implementing a Rails 3 View Resolver - jkfill blog](http://jkfill.com/2011/03/11/implementing-a-rails-3-view-resolver/)

## Changelog

### 0.2.0

* Support cookie-based switching
* Rename helper `mobile_device?` to `mobile?` since it now not only detects mobile device, but also accepts cookie-based switching.
* Ability to have other mounted engines use `mobile?` helper. (Inspired from [Devise](https://github.com/plataformatec/devise/blob/v2.1.2/lib/devise/controllers/helpers.rb))

### 0.1.0

:birthday: First Release

* `*.mobile` view template auto-overriding
* Automatic mobile device detection
* `mobile_device?` helper for controller and view

## License

The MIT License

Copyright (c) 2012 Yu-Cheng Chuang

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
