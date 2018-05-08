App.comment = App.cable.subscriptions.create "CommentChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $("<div class='comment' id='comment_'" + data.comment_id + "><a class='avatar'><img src='/assets/" + data.role + ".jpg' alt='Steve'></a><div class='content'><a class='author'>"+ data.current_user + "</a><div class='metadata'><div class='date'>less than a minute</div></div><div class='text'>" + data.comment_body + "</div></div></div>").insertAfter("#comment_" + parseInt(data.comment_id - 1));
    $("#comment_body").val('');

