module Trestle
  module ActiveJob
    class Engine < Rails::Engine
      config.assets.precompile << 'trestle/active_job.css'
    end
  end
end
