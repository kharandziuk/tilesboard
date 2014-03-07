define [
  'msgbus',
  'app',
  'raphael',
], (
  msgBus,
  Tapp,
  Raphael,
) ->

  Tapp.module('Tiles.Paper', (Paper, Tapp, Backbone, Marionette, $, _) ->

    class Paper.BoardView extends Backbone.View
      el: '#content'
      itemView: Paper.TileView
      initialize: ()->
        console.log 1, @paper
      render: ()->
        @paper = new Raphael(@el, @$el.width(), @$el.height())
        console.log 'render'
        paper = @paper
        @collection.each(()->
          paper.circle(100, 100, 80)
        )

    Paper.Controller =
      initialize: ()->
        boardView = new Paper.BoardView(
          collection: new Backbone.Collection([{count: 10}, {count: 20},])
        )
        Tapp.content.show(boardView)

    msgBus.commands.setHandler(
      'start:tiles:app', Paper.Controller.initialize
    )
  )
