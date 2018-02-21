App.ticket = App.cable.subscriptions.create "TicketChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
  	$(data.view).insertBefore($('.create_task_box')).hide().slideDown(1000);;
