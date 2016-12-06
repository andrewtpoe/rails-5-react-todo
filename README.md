# Rails 5 React TODO

I am putting together this sample project to demonstrate a few techniques that I like using in my Rails projects. My goal is to demonstrate and document setting up an application using Rails as a backend and a React SPA for the front end.

## Initializing the app:

I use a few different configuration options on initialization:

```
  $ rails new rails-5-react-todo --skip-test --skip-turbolinks --skip-action-cable --skip-javascript -d postgresql
```

After initializing the Rails app, I make a few additional edits before committing for the first time and pushing the core up to GitHub.

  - I update the Gemfile to use some of my personal favorites.
  - I initialize NPM.
  - I install the most important NPM packages with the following commands.
    ```
      $ npm install --save babel-polyfill react react-dom react-redux react-router@next recompose redux whatwg-fetch
      $ npm install --save-dev babel-core babel-loader babel-preset-es2015 babel-preset-react babel-preset-stage-0 deep-freeze jasmine karma karma-jasmine karma-phantomjs-launcher karma-spec-reporter karma-webpack react-hot-loader webpack webpack-dev-server
    ```
