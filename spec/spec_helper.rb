# This file was generated by the `rspec --init` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# Require this file using `require "spec_helper"` to ensure that it is only
# loaded once.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration

if ENV['BROWSER']
  if RUBY_PLATFORM == 'opal'
  else
    require 'capybara'
    require 'capybara/dsl'
    require 'capybara/rspec'
    # Needed at the moment to get chrome tests working
    require 'capybara/poltergeist'
  end
end

require 'volt'

if ENV['BROWSER']
  if RUBY_PLATFORM == 'opal'
  else

    require 'volt/server'

    Capybara.server do |app, port|
      require 'rack/handler/thin'
      Rack::Handler::Thin.run(app, :Port => port)
    end

    kitchen_sink_path = File.expand_path(File.join(File.dirname(__FILE__), "apps/kitchen_sink"))
    Capybara.app = Server.new(kitchen_sink_path).app

    if ENV['BROWSER'] == 'poltergeist'
      Capybara.default_driver = :poltergeist
    elsif ENV['BROWSER'] == 'chrome'
      Capybara.register_driver :chrome do |app|
        Capybara::Selenium::Driver.new(app, :browser => :chrome)
      end

      Capybara.default_driver = :chrome
    elsif ENV['BROWSER'] == 'firefox'
    
      # require 'selenium/webdriver'
      # # require 'selenium/client'
      #
      Capybara.default_driver = :selenium
    
      # Capybara.register_driver :selenium_firefox do |app|
      #   Capybara::Selenium::Driver.new(app, :browser => :firefox)
      # end
      # Capybara.current_driver = :selenium_firefox
    end
  end
end


if RUBY_PLATFORM != 'opal'
  RSpec.configure do |config|
    config.run_all_when_everything_filtered = true
    config.filter_run :focus

    # Run specs in random order to surface order dependencies. If you find an
    # order dependency and want to debug it, you can fix the order by providing
    # the seed, which is printed after each run.
    #     --seed 1234
    config.order = 'random'
  end
end
