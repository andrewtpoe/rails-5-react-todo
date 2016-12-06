namespace :test do
  desc "Run the JavaScript and RSpec test suites together."
  task :all do
    # Run the JavaScript test suite
    sh "bundle exec rails test:karma"

    # Run the RSpec test suite
    sh "bundle exec rails test:rspec"
  end

  desc "Run the JavaScript test suite."
  task :karma do
    # Run the JavaScript test suite
    puts ""
    puts "Running JavaScript test suite"
    puts ""
    sh "npm run spec"
  end

  desc "Run the RSpec test suite."
  task :rspec do
    # Checks ENV variables to determine if user specified a file or spec
    spec = ENV["SPEC"]

    if !spec || spec =~ /features/
      # Remove any existing compiled version of the SPA
      puts ""
      puts "Cleaning the public assets to ensure current test files are used"
      puts ""
      sh "bundle exec rails assets:clobber"
      sh "rm -f app/assets/javascripts/application.js"

      # Compile a fresh version of the SPA to ensure tests are run against correct version.
      puts ""
      puts "Compiling production SPA for use in tests"
      puts ""
      sh "npm run build:production_js"
    end

    # Run the RSpec test suite
    puts ""
    puts "Running the RSpec test suite"
    puts ""
    sh "bundle exec rspec #{spec}"
  end
end
