namespace :development do
  desc "Custom start process that begins the Yard server and the webpack watch/build process for the Single Page Application"
  task :start do
    trap('SIGINT') do
      puts ""
      puts "Terminating development processes"
      puts ""
      sleep 1
      exit
    end

    # Remove any residual assets in the asset pipeline
    puts ""
    puts "Cleaning the public assets to ensure current development files are used"
    puts ""
    sh "bundle exec rails assets:clobber"
    sh "rm -f app/assets/javascripts/application.js"

    # Run the build process for Yard Docs
    puts ""
    puts "Generating the latest documentation"
    puts ""
    sh "yard doc"

    # Start the processes needed for development
    puts ""
    puts "Starting background processes used in development"
    puts ""
    sh "bundle exec foreman start -f Procfile.dev"
  end
end
