App.notification = App.cable.subscriptions.create "NotificationChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    
    $("#notifications_count_" + data.recipient).replaceWith("<div id=notifications_count_" + data.recipient + ">" + "<a class='item'><i class='bell large icon'></i>"+ "<div id=count>" + (parseInt($.trim($("#notifications_count_" + data.recipient).text())) + 1) + "</div></a></div>")

    $("<div id=user_notification_" + data.notification_id + ">" + "(" + data.notification_time + ")" + " " + data.notification_actor + " " + data.action +  " ! <hr /> </div>").insertBefore($("#nothing_notification"))

    $("<div id=user_notification_" + data.notification_id + ">" + "(" + data.notification_time + ")" + " " + data.notification_actor + " " + data.action +  " ! <hr /> </div>").insertBefore($("#user_notification_" + (data.notification_id - 1)))

    $("#nothing_notification").remove();
    
    $.playSound("intuition.mp3")