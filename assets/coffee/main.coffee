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

require(['jquery', 'backbone', 'raphael'], ($, Backbone, Raphael) ->
  $(document).ready(()->
    class BoardView extends Backbone.View
      el: '#content'
      #itemView: Paper.TileView
      initialize: ()->
        console.log 1, @paper
      render: ()->
        console.log 'tu', this
        @paper = new Raphael(@el, @$el.width(), @$el.height())
      events: ()->
        'click': ()->
          console.log @
          @paper.circle(100, 100, 80)
    boardView = new BoardView()
    boardView.render()
  )
)
