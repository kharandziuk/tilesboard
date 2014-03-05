COMPONENTS = '../components'

fromLib = (dir, name) ->
  name = name or dir
  return "#{COMPONENTS}/#{dir}/#{name}"

require.config(
  paths:
    backbone : fromLib 'backbone'
    underscore : fromLib 'underscore'
    jquery: fromLib 'jquery/dist', 'jquery'
    raphael: fromLib 'raphael'
    marionette : fromLib 'marionette/lib', 'backbone.marionette'
    'backbone.wreqr' : fromLib 'backbone.wreqr/lib/amd', 'backbone.wreqr'
    'backbone.eventbinder' : fromLib 'backbone.eventbinder/lib/amd', 'backbone.eventbinder'
    'backbone.babysitter' : fromLib 'backbone.babysitter/lib/amd','backbone.babysitter'
  shim:
    underscore :
      exports : '_'
    backbone :
      deps : ['jquery', 'underscore']
      exports : 'Backbone'
    marionette:
      deps: ['backbone']
      exports: 'Marionette'
)

require(['app', 'common', 'paper'], (Tapp) ->
  Tapp.start()
)
