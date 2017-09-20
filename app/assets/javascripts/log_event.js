function logEvent(category, action, label, value)
{
    if(typeof ga === 'function')
    {
        var command = '';

        if(typeof google_tag_manager !== 'undefined')
            command = ga.getAll()[0].get('name') + '.';

        command += 'send';

        ga(command, 'event', {
            'eventCategory': category,
            'eventAction': action,
            'eventLabel': label,
            'eventValue': typeof value === 'undefined' ? 1 : value
        });
    }
    else
        console.log('ga() not defined');
}