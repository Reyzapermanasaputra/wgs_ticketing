App.notification = App.cable.subscriptions.create "NotificationChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $("#notification_" + data.recipient).find("i").removeClass("outline")
    $("#notification_" +  data.recipient + " > .ui.teal").text(parseInt($("#notification_" + data.recipient + " > .ui.teal").text())+1)
    $("<div id=user_notification_" + data.notification_id + "_" + data.recipient + "><div class='ui link celled selection list'  style ='width: 350px;''><div class='ui feed'><div class='event'><div class='label'><img src='/assets/elliot-a41294f12e59e10455cc6a6124e9c75c34db5b5de0cb94f21aeb944713a30c36.jpg' alt='Elliot'></div><div class='content'><div class='date'><span class='time'>"+ data.notification_time + "</span></div><div class='summary'><a>"+data.notification_actor+"</a> "+data.action+"</div></div></div></div></div></div><br />").insertBefore($("#user_notification_" + data.last_notification_id + "_" + data.recipient))
    $("#blank_notification_" + data.recipient ).replaceWith("<div id=user_notification_" + data.notification_id + "_" + data.recipient + "><div class='ui link celled selection list'  style ='width: 350px;''><div class='ui feed'><div class='event'><div class='label'><img src='/assets/elliot-a41294f12e59e10455cc6a6124e9c75c34db5b5de0cb94f21aeb944713a30c36.jpg' alt='Elliot'></div><div class='content'><div class='date'><span class='time'>"+ data.notification_time + "</span></div><div class='summary'><a>"+data.notification_actor+"</a> "+data.action+"</div></div></div></div></div></div><br />")
    try 
      document.getElementById("notification_sound_" + data.recipient ).play(); 
    
