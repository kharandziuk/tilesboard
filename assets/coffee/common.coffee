define ['msgbus', 'app'], (msgBus, Tapp) ->

  Tapp.module('Tiles', (Tiles, Tapp, Backbone, Marionette, $, _) ->)

  Tapp.addRegions
    content: '#content'

  Tapp.addInitializer (options) ->
    #$.when(msgBus.reqres.request('entities:initialize')).done(()->
      msgBus.commands.execute 'start:tiles:app'
    #)
