// serviceworker.js
// The serviceworker context can respond to 'push' events and trigger
// notifications on the registration property
self.addEventListener("push", function (event) {
    var title = event.data && event.data.text() || "Yay a message";
    var body = "We have received a push message";
    var tag = "push-simple-demo-notification-tag";
    var icon = "/assets/favicon/favicon-196x196-0e9f66403794f8e6c787653de8afd761889779839dc114911a909e7662b12ed7.png";

    event.waitUntil(self.registration.showNotification(title, { body: body, icon: icon, tag: tag }));
});