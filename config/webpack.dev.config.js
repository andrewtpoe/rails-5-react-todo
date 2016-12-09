const webpack = require('webpack');

module.exports = {

  devtool: 'eval-source-map',

  entry: {
    client: [
      'webpack-dev-server/client?http://localhost:8080/',
      'webpack/hot/only-dev-server',
      'react-hot-loader/patch',
      './app/client/application.js'
    ]
  },

  // The output files for this should also be included in the .gitignore file.
  // If not, massive git commits will result.
  output: {
    path: '/',
    filename: 'javascripts/application.js',
    publicPath: 'http://localhost:8080/'
  },

  module: {
    loaders: [{
      test: /\.js?$/,
      exclude: /node_modules/,
      loaders: [
        'react-hot-loader/webpack',
        'babel?presets[]=es2015,presets[]=react,presets[]=stage-0'
      ]
    }]
  },

  plugins: [
    new webpack.optimize.OccurenceOrderPlugin(),
    new webpack.HotModuleReplacementPlugin(),
    new webpack.NoErrorsPlugin(),
    new webpack.DefinePlugin({
      'process.env': {
        NODE_ENV: JSON.stringify('development')
      }
    })
  ]
};
