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
    class NewsCollection extends Backbone.Collection
      url: '/tweets/'
      prepare: (paper) ->
        countSum = @reduce(
          (acc, el)-> return acc + el.get('count')
        , 0)
        last = 0
        @each((el)->
          count = el.get('count')
          el.set('y0', 0)
          el.set('x0', last)
          el.set('height', paper.height)
          width = count * paper.width/countSum
          el.set('width', width)
          last += width
        )


    class BoardView extends Backbone.View
      colors: ['#000099', '#FF5050', '#00CC00']
      el: '#content'
      #itemView: Paper.TileView
      initialize: ()->
        @paper = new Raphael(@el, @$el.width(), @$el.height())
      render: ()->
        @collection.prepare(@paper)
        @collection.each((el, i)=>
          attrs = el.attributes
          @paper.rect(attrs.x0, attrs.y0, attrs.width, attrs.height).attr(fill: @colors[i % @colors.length])
        )
    collection = new NewsCollection()
    collection.fetch(
      success: ()->
        boardView = new BoardView(
          collection: collection
        )
        boardView.render()
    )
  )
)
