(function () {
  App.notifications = App.cable.subscriptions.create({
    channel: 'NotificationChannel'
  },
    {
      connected: function () { },
      disconnected: function () { },
      received: function (data) {
        console.log("aaa");
        $('.msg_list').prepend('' + data.notification);
        $counter = $('.counter-notification').text();
        val = parseInt($counter);
        val++;
        $('.counter-notification').text(val);
      },
    });
}).call(this);
