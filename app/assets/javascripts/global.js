
//Google Analytics
var _gaq = _gaq || [];
         _gaq.push(['_setAccount', 'UA-34842097-1']);
         _gaq.push(['_trackPageview']);
         
         (function() {
           var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
           ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
           var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
         })();
         
//Google Analytics



function ImgError(source){
    source.src = "/assets/members/nophoto.jpg";
    source.onerror = "";
    return true;
}

function selectSession(session){
    window.location = '/bills/' + session;
}

function selectSponsorSession(legislator, session){
    window.location = '/sponsor/' + legislator + "/" + session;
}

