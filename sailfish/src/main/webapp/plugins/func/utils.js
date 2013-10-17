(function($) {
    $.utils = {
        isEmpty : function(str) {
            if (str == null || str == "" || str == undefined) {
                return true;
            } else {
                return false;
            }
        },
        toString : function(domer) {
            return $($('<div></div>').html(domer.clone())).html();
        }
    }

})(jQuery);