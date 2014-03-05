define ['backbone.wreqr'], (Wreqr) ->
  return {
    reqres: new Wreqr.RequestResponse()
    commands: new Wreqr.Commands()
    events: new Wreqr.EventAggregator()
  }
