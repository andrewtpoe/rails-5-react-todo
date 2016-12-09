# Rails 5 React TODO

This sample project demonstrates integrating webpack with the asset pipeline using the latest cutting edge JavaScript tools. The goal is to demonstrate and document setting up an application using Rails as a backend and a React SPA for the front end.

## Getting started:

Prerequisites:

  - You must have Ruby installed. It is recommended that you use a version manager such as rbenv. The Gemfile for this application specifies version 2.3.1.

  - You must have Node installed. It is recommended that you use a version manager such as nvm. The JS within this application specifies Node version 6.9.1.

  - You must have PostgreSQL installed. It is recommended that you use homebrew to install this.

Follow these steps to set up your development environment for this project:

  - Fork/ clone this project to get the source code on your local machine.

  - Run: `$ bundle install`

  - Run: `$ npm install`

  - Run: `$ bundle exec rails db:setup`

### Development

This application relies on a few background processes for development. Start these with a rake task:

  ```
    $ bundle exec rails development:start
   ```  

The processes started by this command include:

  - Yard: documentation for this application is available [here](http://localhost:9000/docs/index)

  - Webpack Dev Server: This enables hot reloading of the JavaScript SPA found in app/client.

### Testing

This project uses Jasmine + Karma to test the JavaScript, and RSpec + Capybara to test the Ruby on Rails and the user interface. There are a few rake tasks set up that handle various cleanup and compiling needs based on the test suite you are running. Please use them instead of the traditional commands like `npm run spec` or `bundle exec rspec`.

To run both suites together, enter the command:

  ```
  $ bundle exec rails test:all
  ```

To run the test suite for the client JavaScript, enter the command:

  ```
    $ bundle exec rails test:karma
  ```

To run the test suite for Ruby on Rails, enter the command:

  ```
    $ bundle exec rails test:rspec
  ```

You can specify a spec file or location using an environment variable:

  ```
    $ bundle exec rails test:rspec SPEC=spec/features/the_application_spec.rb:5
  ```

### Deployment

Want to put this app up on Heroku? You will need to build it first. Enter the following command:

  ```
    $ bundle exec production:build
  ```

This will compile the SPA in production mode, then compile the Rails Asset Pipeline. From there it is a simple `git push heroku master` away from being live on your site.


Now that you are familiar with how to work within this application, let me show you how it is set up and explain a bit of why it is configured like this.

## Initialization:

I use a few different configuration options on initialization for this type of application:

  ```
    $ rails new rails-5-react-todo --skip-test --skip-turbolinks --skip-action-cable --skip-javascript -d postgresql
  ```

After initializing the Rails app, make a few additional edits before committing for the first time and pushing the core up to GitHub.

  - I update the Gemfile to use some of my personal favorites.
  - I initialize NPM.
  - I install the most important NPM packages with the following commands.

    ```
      $ npm install --save babel-polyfill react react-dom react-redux react-router@next recompose redux redux-thunk whatwg-fetch

      $ npm install --save-dev babel-core babel-loader babel-preset-es2015 babel-preset-react babel-preset-stage-0 deep-freeze jasmine karma karma-jasmine karma-phantomjs-launcher karma-spec-reporter karma-webpack react-hot-loader@next webpack webpack-dev-server
    ```

## Configuration:

There are several configuration and rake task files added to this application that enable various bits of functionality such as hot reloading the React SPA, compiling minified and uglified JS, starting the development processes, and running the spec suites. The files added in this step are listed below:

  - config/webpack.dev.config.js
  - config/webpack.prod.config.js
  - lib/tasks/development.rake
  - lib/tasks/production.rake
  - lib/tasks/test.rake
  - spec/karma.config.js
  - asset_host.js

You are welcome to browse these settings and reconfigure them as you'd like.

One of the most interesting things set up at this time is hot reloading of that SPA. It is enabled thanks to the configuration in `config/webpack.dev.config.js`, `asset_host.js`, and this section of code in `config/environments/development.rb`:

  ```
    # Enable webpack-dev-server running on port 8080 for hot reloading
    config.action_controller.asset_host = Proc.new { |source|
      if source =~ /application.js$/i
        "http://localhost:8080"
      end
    }
  ```

To ensure that everything is working correctly at this time, a root route has been added along with a corresponding view file (`app/views/application/main.html.haml`). This view file simply renders the JavaScript SPA. Additionally, JS files have been added to `app/client` to render a simple "Hello, world!" in the browser.

Last but not least, a few simple "this is working" specs have been added to confirm functionality.
