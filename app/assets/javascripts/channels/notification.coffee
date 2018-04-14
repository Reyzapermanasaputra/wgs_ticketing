App.notification = App.cable.subscriptions.create "NotificationChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $("#notifications_count_" + data.recipient).replaceWith("<div id=notifications_count_" + data.recipient + ">" + "<a class='item'><i class='bell large icon'></i>"+ (parseInt($.trim($("#notifications_count_" + data.recipient).text())) + 1) + "</a></div>")
    $.playSound("intuition.mp3")