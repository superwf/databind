gulp = require('gulp')
livereload = require('gulp-livereload')
wiredep = require('wiredep')
jade = require('gulp-jade')
coffee = require('gulp-coffee')
myth = require('gulp-myth')
karma = require('gulp-karma')

gulp.task 'test', (done)->
  karma.start({
    configFile: __dirname + '/karma.conf.js'
    singleRun: true
  }, done)

frontendPaths = {
  myth: './app/css/*.css'
  coffee: ["app/*.coffee"]
  jade: ['app/*.jade']
}

gulp.task 'jade', ->
  gulp.src(frontendPaths.jade).pipe(jade(pretty: true))
  .pipe(gulp.dest('./public'))

gulp.task 'myth', ->
  gulp.src(frontendPaths.myth)
    .pipe(myth())
    .pipe(gulp.dest('./public/css'))
    .pipe(livereload())

gulp.task 'wiredep', ['jade'], ->
  wiredep({
    src: 'public/index.html',
    directory: 'public/js/bower_components',
  })

gulp.task "coffee", (done) ->
  gulp.src(frontendPaths.coffee).pipe(coffee(bare: true)).pipe(gulp.dest("./public/js")).on "end", done
  return

# watch and livereload
gulp.task 'watch', ->
  gulp.watch(frontendPaths.myth, ['myth'])
  gulp.watch(frontendPaths.jade, ['jade'])
  # only recompile the one file which is changed, so not use the jade task
  gulp.watch(frontendPaths.jade).on "change", (e) ->
    gulp.src(e.path).pipe(jade().on("error", (err) ->
      console.log err
      return
    )).pipe(gulp.dest('./public')).pipe(livereload())
    return

  # when coffee file changed, only recompile the one file, so not use the coffee task
  gulp.watch(frontendPaths.coffee).on "change", (e) ->
    gulp.src(e.path).pipe(coffee(bare: true).on("error", (err) ->
      console.log err
      return
    )).pipe(gulp.dest('./public/js')).pipe(livereload())
    return
  return

# serverend watch and livereload
gulp.task 'develop', ->
  livereload.listen()

gulp.task 'default', [
  'jade'
  'wiredep'
  'myth'
  'coffee'
  'develop'
  'watch'
]
