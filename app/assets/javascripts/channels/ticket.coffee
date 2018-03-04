App.ticket = App.cable.subscriptions.create "TicketChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
  	$(data.view).insertBefore($('#project_id_' + data.project_id + '_user_id_' + data.user_id_1)).hide().slideDown(1000);
  	$(data.view).insertBefore($('#project_id_' + data.project_id + '_user_id_' + data.user_id_2)).hide().slideDown(1000);