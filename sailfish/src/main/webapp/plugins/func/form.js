(function ($) {

    $.fn.setFormValues = function(data) {

        this.each(function() {
            $(this).resetForm();

            $(this).find(":text,:password,:hidden,textarea,select").each(
                function() {
                    var _name = $(this).attr("name");
                    $(this).val(data[_name]);
                });

            $(this).find(":radio,:checkbox").each(function() {
                var _name = $(this).attr("name");
                var value = data[_name] + "";

                if (value != "" && value.indexOf($(this).val()) >= 0) {
                    $(this).attr("checked", true);
                }
            });
        });
    };

})(jQuery);