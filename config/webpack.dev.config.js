const webpack = require('webpack');

module.exports = {

  devtool: 'eval',

  entry: {
    client: [
      'webpack-dev-server/client?http://localhost:8080/',
      'webpack/hot/only-dev-server',
      './app/client/client.js'
    ]
  },

  // The output files for this should also be included in the .gitignore file.
  // If not, massive git commits will result.
  output: {
    filename: 'javascripts/application.js',
    publicPath: 'http://localhost:8080/'
  },

  module: {
    loaders: [{
      test: /\.js?$/,
      exclude: /node_modules/,
      loaders: ['react-hot', 'babel?presets[]=es2015,presets[]=react,presets[]=stage-0']
    }]
  },

  plugins: [
    new webpack.DefinePlugin({
      'process.env': {
        NODE_ENV: JSON.stringify('development')
      }
    }),
    new webpack.HotModuleReplacementPlugin(),
    new webpack.NoErrorsPlugin()
  ]
};
