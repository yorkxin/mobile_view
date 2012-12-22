class PagesController < ApplicationController
  def default
  end

  # This page has action_view.html.erb and action_view.mobile.html.erb
  def action_view
  end

  # This page uses a partial _partial.html.erb with _partial.mobile.html.erb
  def partial_view
  end

  # This page uses mobile_device? helper to determine the content to be rendered
  def conditional
    @text = if mobile_device?
      "Hi Mobile!"
    else
      "Hi Desktop!"
    end
  end
end