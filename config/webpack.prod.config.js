const webpack = require('webpack');

module.exports = {
  entry: './app/client/client.js',
  output: {
    path: './app/assets/javascripts/',
    filename: 'application.js',
  },
  module: {
    loaders: [{
      test: /\.js?$/,
      exclude: /node_modules/,
      loaders: ['babel?' + JSON.stringify({
        presets: ['es2015', 'react', 'stage-0'],
        env: {
          production: {
            presets: ['react-optimize']
          }
        }
      })],
    }]
  },
  plugins: [
    new webpack.DefinePlugin({
      'process.env': {
        NODE_ENV: JSON.stringify('production')
      }
    }),
    new webpack.optimize.UglifyJsPlugin({
      // Don't beautify output (enable for neater output)
      beautify: false,

      // Eliminate comments
      comments: false,

      // Compression specific options
      compress: {
        warnings: false,

        // Drop `console` statements
        drop_console: true
      },

      // Mangling specific options
      mangle: {
        // Don't care about IE8
        screw_ie8 : true,
      }
    }),
    new webpack.optimize.DedupePlugin(),
  ]
}
