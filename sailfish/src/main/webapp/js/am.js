$(function() {
    var miniHeight = $("#container").height();
    var maxHeight = document.body.clientHeight;

    if(maxHeight > (miniHeight + 50)) {
        $("#container").height(miniHeight + (maxHeight - miniHeight - 50));
    }

    var thisUrl = window.location.href;
    $("#moduleNav li a").each(function() {
        var href = $(this).attr("href");
        if(matchUrl(href, thisUrl)) {
            $(this).parent("li").addClass("active");
            return false;
        }
    });
});

function matchUrl(pUrl, cUrl) {

    var moduleUrl = pUrl.split("/");
    var isMatch = true;
    $.each(moduleUrl, function(i, n) {
        if(cUrl.indexOf("/" + n) < 0) {
            isMatch = false;
            return false;
        }
    });

    return isMatch;
}