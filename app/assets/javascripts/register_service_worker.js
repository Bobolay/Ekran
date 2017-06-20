// application.js
// Register the serviceWorker script at /serviceworker.js from your server if supported
if (navigator.serviceWorker) {
    navigator.serviceWorker.register('/serviceworker.js')
        .then(function(reg) {
            console.log('Service worker change, registered the service worker');
        });
}
// Otherwise, no push notifications :(
else {
    console.error('Service worker is not supported in this browser');
}

function register_sw(e) {
    navigator.serviceWorker.ready.then(function (serviceWorkerRegistration) {
        serviceWorkerRegistration.pushManager.getSubscription().then(function (subscription) {
            $.post("/push", { subscription: subscription.toJSON(), message: "You clicked a button!" });
        });
    });
}

//$(".webpush-button").on("click", register_sw);
register_sw()