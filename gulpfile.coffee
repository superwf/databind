gulp = require('gulp')
livereload = require('gulp-livereload')
wiredep = require('wiredep')
jade = require('gulp-jade')
coffee = require('gulp-coffee')
less = require('gulp-less')
karma = require('gulp-karma')

gulp.task 'test', (done)->
  karma.start({
    configFile: __dirname + '/karma.conf.js'
    singleRun: true
  }, done)

frontendPaths = {
  less: './app/less/*.less'
  coffee: ["app/*.coffee"]
  jade: ['app/*.jade']
}

gulp.task 'jade', ['wiredep'], ->
  gulp.src(frontendPaths.jade).pipe(jade())
  .pipe(gulp.dest('./app'))

gulp.task 'less', ->
  gulp.src(frontendPaths.less)
    .pipe(less())
    .pipe(gulp.dest('./app/css'))
    .pipe(livereload())

gulp.task 'wiredep', ->
  wiredep({
    src: 'app/index.jade',
    directory: 'app/bower_components',
  })

gulp.task "coffee", (done) ->
  gulp.src(frontendPaths.coffee).pipe(coffee(bare: true)).pipe(gulp.dest("./app")).on "end", done
  return

# watch and livereload
gulp.task 'watch', ->
  gulp.watch(frontendPaths.less, ['less'])
  gulp.watch(frontendPaths.jade, ['jade'])
  # only recompile the one file which is changed, so not use the jade task
  gulp.watch(frontendPaths.jade).on "change", (e) ->
    gulp.src(e.path).pipe(jade().on("error", (err) ->
      console.log err
      return
    )).pipe(gulp.dest('./app')).pipe(livereload())
    return

  # when coffee file changed, only recompile the one file, so not use the coffee task
  gulp.watch(frontendPaths.coffee).on "change", (e) ->
    gulp.src(e.path).pipe(coffee(bare: true).on("error", (err) ->
      console.log err
      return
    )).pipe(gulp.dest('./app')).pipe(livereload())
    return
  return

# serverend watch and livereload
gulp.task 'develop', ->
  livereload.listen()

gulp.task 'default', [
  'jade'
  'less'
  'coffee'
  'develop'
  'watch'
]
