module.exports = (grunt) ->
  require('time-grunt')(grunt)
  require('load-grunt-tasks')(grunt)

  appConfig = grunt.file.readJSON('package.json')

  pathsConfig = (appName)->
    @app = appName || appConfig.name

    return {
      app: @app
      bower: 'static/components'
      css: 'static/css'
      coffee: 'assets/coffee'
      js: 'static/js'
      img: 'static/img'
      fonts: 'static/fonts'
      temlatesSrc: 'assets/tmpl'
      temlatesDst: 'static/js/tmpl'
    }

  grunt.initConfig({
    paths: pathsConfig(),
    pkg: appConfig,
    watch:
        grunt:
          files: ['Gruntfile.coffee']
        coffee:
          files: ['app.coffee', '<%= paths.coffee %>/**/*.coffee']
          tasks: ['coffee']
    bower:
      install:
        options:
          targetDir: '<%= paths.bower %>'
          layout: 'byComponent'
          #install: false
          verbose: false
          cleanTargetDir: true
          cleanBowerDir: false
          bowerOptions: {}
    coffee: {
      frontend:
        options:
          bare: true
        expand: true
        flatten: false
        cwd: '<%= paths.coffee %>'
        src: ['**/*.coffee']
        dest: '<%= paths.js %>'
        ext: '.js'
      server:
        options:
          bare: true
        files:
          'app.js': 'app.coffee'
    }
  })

  grunt.registerTask('runApp', ()->require('./app.js'))

  grunt.registerTask('build', ['coffee', 'bower'])
  grunt.registerTask('server', ['build', 'runApp','watch'])
  grunt.registerTask('default', ['server'])
