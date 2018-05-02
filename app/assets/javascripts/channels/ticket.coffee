App.ticket = App.cable.subscriptions.create "TicketChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $('#index_' + data.project_id).html(data.view)