namespace :production do
  desc "Custom compile process that incorporates building the SPA with webpack"
  task :build do
    # Remove the old assets
    puts ""
    puts "Deleting any previously compiled assets"
    puts ""
    sh "bundle exec rails assets:clobber"
    sh "rm -f app/assets/javascripts/application.js"

    # Compile the Single Page Application
    puts ""
    puts "Compiling the Single Page Application found in app/client"
    puts ""
    sh "npm run build:production_js"

    # Compile the Rails Asset Pipeline
    puts ""
    puts "Compiling the Rails Asset Pipeline"
    puts ""
    temp_secret = `bundle exec rails secret`
    sh "export SECRET_KEY_BASE=#{temp_secret}"
    sh "export RAILS_ENV=production"
    sh "bundle exec rails assets:precompile"
    sh "unset SECRET_KEY_BASE"
    sh "unset RAILS_ENV"
  end
end
