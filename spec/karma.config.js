var webpackConfig = require('../config/webpack.dev.config')

module.exports = function (config) {
    config.set({
        basePath: '../',
        browsers: ['PhantomJS'],
        files: ['spec/spec_helper.js'],
        frameworks: ['jasmine'],
        plugins: [
            require('karma-webpack'),
            'karma-spec-reporter',
            'karma-jasmine',
            'karma-phantomjs-launcher'
        ],
        preprocessors: {
            'spec/spec_helper.js': 'webpack'
        },
        reporters: ['spec'],
        webpack: webpackConfig,
        webpackMiddleware: {noInfo: true}
    });
};
