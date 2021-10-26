const { config, environment, Environment  } = require('@rails/webpacker')
const webpack = require('webpack')
const WebpackerPwa = require('webpacker-pwa');
new WebpackerPwa(config, environment);

environment.plugins.prepend('Provide',
    new webpack.ProvidePlugin({
        $: 'jquery',
        jQuery: 'jquery',
        moment: 'moment'
    })
)

module.exports = environment
