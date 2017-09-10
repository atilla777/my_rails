class RailsPanelStrategy < Strategy
  # for Google Chrome RailsPanel extension
  category :test_browser_panel
  name 'Chrome Rails panel'
  gems { gem 'meta_request', groups: [:development, :test] }
end
