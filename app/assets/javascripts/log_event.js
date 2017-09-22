function logGAObject(type, object)
{
    if(typeof ga === 'function')
    {
        var command = '';

        if(typeof google_tag_manager !== 'undefined')
            command = ga.getAll()[0].get('name') + '.';

        command += 'send';

        ga(command, type, object);
    }
    else
        console.log('ga() not defined');
}

function logEvent(category, action, label, value){
    var event_data = {
        'eventCategory': category,
        'eventAction': action,
        'eventLabel': label,
        'eventValue': typeof value === 'undefined' ? 1 : value
    }

    logGAObject("event", event_data)

    if (typeof dataLayer !== 'undefined'){
        event_data.event = category
        dataLayer.push(event_data);
    }
    else {
        console.log("dataLayer not defined")
    }
}

function logPageView(name_or_url){
    logGAObject("pageview", name_or_url)
}