App.remove_ticket = App.cable.subscriptions.create "RemoveTicketChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $("#ticket_" + data.id).remove();
