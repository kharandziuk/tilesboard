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
    Paper.BoardView = Marionette.ItemView.extend(
      template: "#foo"
    )
    Paper.Controller =
      initialize: ()->
        #news = msgBus.reqres.request('entities:news')
        boardView = new Paper.BoardView()
        Tapp.content.show(boardView)

    msgBus.commands.setHandler(
      'start:tiles:app', Paper.Controller.initialize
    )
  )
