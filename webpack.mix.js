const mix = require("laravel-mix");

/*
 |--------------------------------------------------------------------------
 | Mix Asset Management
 |--------------------------------------------------------------------------
 |
 | Mix provides a clean, fluent API for defining some Webpack build steps
 | for your Laravel applications. By default, we are compiling the CSS
 | file for the application as well as bundling up all the JS files.
 |
 */

mix.js("resources/js/app.js", "public/js")
    .version()
    .sass("resources/scss/app.scss", "public/css")
    .options({
        processCssUrls: false,
        postCss: [
            require("postcss-css-variables")({
                preserve: true,
            }),
            require("autoprefixer")({
                cascade: false,
                grid: "autoplace",
            }),
            require("postcss-gap-properties"),
        ],
    })
    .sourceMaps()
    .webpackConfig({ devtool: "source-map" })
    .version();

mix.browserSync({
    host: "127.0.0.1",
    proxy: "localhost",
    open: false,
    files: ["app/**/*.php", "resources/views/**/*.php", "public/js/**/*.js", "public/css/**/*.css"],
    watchOptions: {
        usePolling: true,
        interval: 500,
    },
});
