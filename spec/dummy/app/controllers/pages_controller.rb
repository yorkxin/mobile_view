class PagesController < ApplicationController
  # This page has nothing specific for mobile devices
  def default
  end

  # This page has action_view.html.erb and action_view.mobile.html.erb
  def action_view
  end

  # This page uses a partial _partial.html.erb with _partial.mobile.html.erb
  def partial_view
  end

  # This page uses yet-another layout, with yet-another.mobile layout available
  def layout_template
    render :layout => "yet-another"
  end

  # This page uses mobile? helper to determine the content to be rendered
  def conditional
    @text = if mobile?
      "Hi Mobile!"
    else
      "Hi Desktop!"
    end
  end
end