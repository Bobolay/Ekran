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
    logGAObject("event", {
        'eventCategory': category,
        'eventAction': action,
        'eventLabel': label,
        'eventValue': typeof value === 'undefined' ? 1 : value
    })

    if (typeof dataLayer != 'undefined'){
        var event_name = category + "__" + action + "__" + label
        if ( value && value.length){
            event_name += "__" + value
        }
        dataLayer.push({'event': event_name });
    }
}

function logPageView(name_or_url){
    logGAObject("pageview", name_or_url)
}