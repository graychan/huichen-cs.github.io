// addListener and trackOutboundLink come from
//  https://developers.google.com/analytics/devguides/collection/analyticsjs/events
/**
 * Utility to wrap the different behaviors between W3C-compliant browsers
 * and IE when adding event handlers.
 * 
 * @param {Object} element Object on which to attach the event listener.
 * @param {string} type A string representing the event type to listen for
 *                  (e.g. load, click, etc.).
 * @param {function()} callback The function that receives the notification.
 * */

function addListener(element, type, callback) {
    if (element.addEventListener) 
            element.addEventListener(type, callback);
    else if (element.attachEvent) 
        element.attachEvent('on' + type, callback);
}


function isOutboundLink(href) {
    var localHostRE = new RegExp(location.host);
    var httpLead = new RegExp("^http", "i");

    if (!localHostRE.test(href)) {
        if (httpLead.test(href)) {
            return true;
        } else { 
            return false;
        }
    } else {
        return false;
    }
    /*
    if (!localHostRE.test(href) && httpLead.test(href)) {
        return true;
    } else {
        return false;
    }
    */
}

/**
 * Function that tracks a click on an outbound link in Google Analytics.
 * This function takes a valid URL string as an argument, and uses that URL string
 * as the event label.
 * */
var trackOutboundLink = function(url) {
    __gaTracker('send', 'event', 'outbound', 'click', url, {'hitCallback':
        function () {
            document.location = url;
        }
    });
}

/**
 * add a tracker for an element
 * */
function addTracker(anchor)
{
    addListener(anchor, 'click', function() {
        trackOutboundLink(anchor.href); return false;
    });
}

// comments come from 
//  https://developers.google.com/analytics/devguides/collection/analyticsjs/advanced
/**
 * Creates a temporary global ga object and loads analy  tics.js.
 * Paramenters o, a, and m are all used internally.  They could have been declared using 'var',
 * instead they are declared as parameters to save 4 bytes ('var ').
 *  
 * @param {Window}      i The global context object.
 * @param {Document}    s The DOM document object.
 * @param {string}      o Must be 'script'.
 * @param {string}      g URL of the analytics.js script. Inherits protocol from page.
 * @param {string}      r Global name of analytics object.  Defaults to 'ga'.
 * @param {DOMElement?} a Async script tag.
 * @param {DOMElement?} m First script tag in document.
 * */
(function(i,s,o,g,r,a,m) 
{
    i['GoogleAnalyticsObject'] = r; // Acts as a pointer to support renaming.

    // Creates an initial ga() function.  The queued commands will be executed once analytics.js loads.
    i[r] = i[r] || function() {
            (i[r].q = i[r].q || []).push(arguments)
    },

    // Sets the time (as an integer) this tag was executed.  Used for timing hits.
    i[r].l=1*new Date();


    // Insert the script tag asynchronously.  Inserts above current tag to prevent blocking in
    // addition to using the async attribute.
    a = s.createElement(o), m = s.getElementsByTagName(o)[0];
    a.async=1;
    a.src=g;
    m.parentNode.insertBefore(a,m);
})(window, document, 'script', '//www.google-analytics.com/analytics.js', '__gaTracker');

// notice ga has been renated to __gaTracker to avoid potential name conflict
__gaTracker('create', 'UA-7942530-6', 'auto');
__gaTracker('require', 'linkid', 'linkid.js');
__gaTracker('send', 'pageview');

var anchors = document.getElementsByTagName('a');
var filetype = new RegExp
(
    '(\\.pdf$)|' + 
    '(\\.zip$)|' + 
    '(\\.ppt$)|' + 
    '(\\.pptx$)|' + 
    '(lecture[0-9]+_ex[0-9]+\\.html$)|' +
    '(lecture[0-9]+_ex[0-9]+\\.php$)'
);



for (var i=0; i<anchors.length; i ++) {
    console.log("Before: " + anchors[i].href);
    if (filetype.test(anchors[i].href)) {
        console.log("Track: " + anchors[i].href);
        addTracker(anchors[i]);
    } else if (isOutboundLink(anchors[i].href)) {
        console.log("Track: " + anchors[i].href);
        addTracker(anchors[i]);
    }
}






