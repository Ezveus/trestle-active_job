Trestle.configure do |config|
  config.hook("stylesheets") do
    stylesheet_link_tag "trestle/active_job"
  end

  config.hook("view.header") do
    render "trestle/active_job/header"
  end
end
