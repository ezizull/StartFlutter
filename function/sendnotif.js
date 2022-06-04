var admin = require("firebase-admin");

var serviceAccount = require("D:/belajar/flutter/start/serviceAccountKey.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL:
    "https://start-firebase-49b01-default-rtdb.asia-southeast1.firebasedatabase.app",
});

var deviceToken =
  "c70A3P2iT0CyipBmpBlMuO:APA91bEDcWhw5F_ZypIaKX7OLIRHC6ktvxoy_pxXcGl-9VfNMjXR48QzzrmkMaiboqlXLo7G549Ic7O-e0wE9ujIf06eC33NuduiJbHTHQIhtRh0hjqAE2l6bt43gRNqJAAOU7Nr_41x";

var message = {
  data: {
    title: "GalleryHub",
    body: "you have some notification in your background or foreground phone",
  },
  notification: {
    title: "GalleryHub",
    body: "you have some notification in your background or foreground phone",
  },
  token: deviceToken,
};

// Send a message to the device corresponding to the provided
// registration token.
admin
  .messaging()
  .send(message)
  .then((response) => {
    // Response is a message ID string.
    console.log("Successfully sent message:", response);
  })
  .catch((error) => {
    console.log("Error sending message:", error);
  });
