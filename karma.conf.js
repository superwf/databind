// Karma configuration
// Generated on Sat Mar 07 2015 19:41:25 GMT+0800 (CST)

shareConf = require('./karma.conf.share.js');

module.exports = function(config) {
  shareConf(config);
  config.set({

    // list of files / patterns to load in the browser
    files: [
      {pattern: "public/js/bower_components/jquery/dist/jquery.js", included: true, served: true, watched: false},
      {pattern: 'public/js/*.js', included: false, served: true, watched: false},
      {pattern: 'test/*.coffee', included: true, served: true, watched: true},
      //'app/*.js',
      {pattern: 'public/*.html', included: false, served: true, watched: false}
    ],

    proxies: [
    ]

  });
};
