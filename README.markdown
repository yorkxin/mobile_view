# MobileView

Easily specify mobile-specific view template for mobile devices in Rails application.

**Warning** This gem still has major version of `0` which means it's during early alpha and APIs and usages are subject to change. Strategies and implementations may not be the best practice. Bugs may exist. Feel free to send patches for everyting that you think it's not good or would like to change. I'll add your name to README after approved.

## Installation

Add this line to your application's Gemfile:

    gem "mobile_view", "~> 0.2.0"

And then execute:

    $ bundle

Add these lines into your base controller:

```ruby
class ApplicationController < ActionController::Base
  has_mobile_view
end
```

## Dependency

  * Rails 3.2.x

Development dependency:

  * RSpec
  * Capybara
  * [PhantomJS](http://phantomjs.org/) (Capybara's integration test is driven by [poltergeist](https://github.com/jonleighton/poltergeist), for easier cookie and header modification.)

## Usage

### `action.mobile.html.erb` View Template

If you have problems like this:

1. You have a view template for `posts#show`, with many DOM elements and JavaScripts, which is good for desktop, but painful for mobile devices. (In such case even Responsive Web Design with CSS media queries doesn't help you much.)
* You're tired of `<%= render_something if mobile? %>` conditional hell.
* You want to make a mobile-friendly view, which is mostly different from desktop version, build form scratch.

With MobileView, you can add `posts/show.mobile.html.erb` along with `posts/show.html.erb`. Then, if the browser is a mobile device, Rails will choose the mobile template first:

* <tt>posts/show.html.erb</tt> = default view for `posts#show`
* <tt>posts/show<b>.mobile</b>.html.erb</tt> = mobile view for `posts#show`

It also works for partial views and layout views:

* <tt>posts/_post.html.erb</tt> = default view for partial view `posts/post`
* <tt>posts/_post<b>.mobile</b>.html.erb</tt> = mobile view for partial view `posts/post`

and

* <tt>layouts/application.html.erb</tt> = default layout
* <tt>layouts/application<b>.mobile</b>.html.erb</tt> = mobile layout

#### ERb, HAML; JSON, JavaScript etc. All Supported.

You can use any template handlers (`erb`, `haml` etc.) and formats (`json`, `js`, `xml` etc.) available in your Rails application.  All you have to do is add another view template with `mobile` after the view's main name (before locale, format and handler). It follows the naming rule of Rails's view template files; the only difference is the `.mobile` interpolation:
 
* <tt>prefix/name<i>.locale.format.handler</i></tt> = default view
* <tt>prefix/name<b>.mobile</b><i>.locale.format.handler</i></tt> = mobile view

#### Auto Fallback

When a mobile version of partial view is not available, it will automatically fallback to default (non-mobile) version.

### `mobile?` Helper

The `mobile?` helper tells you if currently MobileView switched to mobile version or not. It is available in controller and view.

The situation of "switched to mobile view" could be:

* accessing with a mobile device browser, or
* manually switched to mobile view (see [cookie-based switching](#cookie-based-mobile-view-switching) below).

Returns `true` if it switched to mobile view, `false` otherwise.

Example:

```ruby
# in controller
@text += "Hello! Mobile" if mobile?
```

```erb
<%# in view %>
<%= render_advertisement unless mobile? %>
```

#### Mounted Engine

To use `mobile?` helper in a mounted engine, for example, [Rails Cell](https://github.com/apotonick/cells), simply include the `MobileView::ControllerAdditions` module:

```ruby
class PostCell < Cell::Rails
  include MobileView::ControllerAdditions
  has_mobile_view
end
```

## Cookie-based Mobile View Switching

By setting `mobile` cookie, you can force it to load mobile views. This is helpful when debugging the app in desktop browsers, or allowing user to switch to mobile version manually.

The cookie injection of manual switching should happen **before** `has_mobile_view` is invoked.

Example:

```ruby
class AppliactionController < ActionController::Base
  before_filter :manual_mobile_switching

  has_mobile_view

  protected
  # Detects `_mobile_view` parameter.
  #
  # If it is 'yes', force turn on mobile view by setting cookie mobile=1;
  # if it is 'no', force turn off mobile view by setting cookie mobile=0;
  # if it is 'auto', remove mobile cookie and fallback to User-Agent mode;
  # otherwise, no effect.
  def mobile_switching
    case params[:_mobile_view]
    when 'yes'
      force_mobile!
    when 'no'
      force_non_mobile!
    when 'auto'
      dismiss_mobile_forcing!
    end
  end
end
```

## Known Issues

### iPad / Tablets → Mobile View

According to the algorithm of [Rack::MobileDetect](https://github.com/talison/rack-mobile-detect/), iPad will be seen as a Mobile Device. This may be a fail assumption if you want to show your desktop website to iPad and tablet users. This can (may) be resolved by replacing mobile device detection logic or add more tablet-specific methods.

Workaround: Force switch to non-mobile version when client is iPad:

```ruby
class AppliactionController < ActionController::Base
  before_filter :force_non_mobile!, :if => :ipad?

  # still have to invoke has_mobile_view after force_mobile!
  has_mobile_view
end
```

## References

* [#269 Template Inheritance - RailsCasts](http://railscasts.com/episodes/269-template-inheritance)
* [#397 Action View Walkthrough (pro) - RailsCasts](http://railscasts.com/episodes/397-action-view-walkthrough)
* [Implementing a Rails 3 View Resolver - jkfill blog](http://jkfill.com/2011/03/11/implementing-a-rails-3-view-resolver/)

## Changelog

### 0.3.0

* [breaking] Fron now on you have to invoke `has_mobile_view` in controller explicitly.
* Wrap cookie-based switching into a bunch of helper methods for code readability.

### 0.2.0

* Support cookie-based switching
* [breaking] Rename helper `mobile_device?` to `mobile?` since it now not only detects mobile device, but also accepts cookie-based switching.
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
