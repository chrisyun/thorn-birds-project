(function ($) {

    function CWnd(options) {

        var defaults = {
            id: "",
            title: "",
            body: "",
            foot: "",
            width: "",
            height: "",
            cls: ""
        };

        this.options = $.extend(defaults, options);

        if ($("#" + options.id).length <= 0) {
            var _content = $('<div class="modal-content"></div>');
            var _header = $('<div class="modal-header">' +
                '<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>' +
                '<h4 class="modal-title">' + options.title + '</h4></div>');
            var _body = $('<div class="modal-body"></div>').append(options.body);
            var _footer = $('<div class="modal-footer"></div>').append(options.foot);

            _content.append(_header);
            _content.append(_body);
            _content.append(_footer);

            var _dialog = $('<div class="modal-dialog"></div>');
            _dialog.append(_content);

            var _dialog_div = $('<div id="' + options.id + '" tabindex="-1" class="modal fade" aria-hidden="true" role="dialog"></div>');
            _dialog_div.append(_dialog);

            _dialog_div.appendTo("body");

            $("#" + options.id).modal({
                backdrop: 'static',
                keyboard: false,
                show: false
            });
            $("#" + options.id).modal("hide");
        } else {
            // reset
            $("#" + options.id + " > .modal-header > h4").html(options.title);
            $("#" + options.id + " > .modal-body").empty();
            $("#" + options.id + " > .modal-body").append(options.body);
            $("#" + options.id + " > .modal-footer").empty();
            $("#" + options.id + " > .modal-footer").append(options.foot);
        }

        if (!$.utils.isEmpty(options.width)) {
            $("#" + options.id + " > .modal-dialog").css("width", options.width);
        } else {
            $("#" + options.id + " > .modal-dialog").css("width", "");
        }

        var _modalBody = $("#" + options.id + " > .modal-body");

        if (!$.utils.isEmpty(options.height)) {
            _modalBody.css("height", options.height);
        } else {
            _modalBody.css("height", "");
        }

        _modalBody.removeClass();
        _modalBody.addClass("modal-body");

        if (!$.utils.isEmpty(options.cls)) {
            _modalBody.addClass(options.cls);
        }
    };

    CWnd.prototype.show = function () {
        $("#" + this.options.id).modal("show");
    };

    CWnd.prototype.hide = function () {
        $("#" + this.options.id).modal("hide");
    };

    CWnd.prototype.setTitle = function (title) {

        if (!$.utils.isEmpty(title)) {
            title = this.options.title;
        }
        $("#" + this.options.id + " > .modal-header > h4").html(title);
    };

    $.dialog = {
        progress: function (action) {

            var cwnd = new CWnd(
                {
                    id: "_progressDialog",
                    title: "请求处理中...",
                    width: 400,
                    body: '<div class="progress progress-striped active" style="margin-top: 20px;">'
                        + '<div class="bar" id="_progressDialogBar" style="width: 0%;"></div>',
                    foot: '<a class="btn" data-dismiss="modal">关闭</a>'
                });

            if (action != null && action == "close") {
                cwnd.hide();
                return;
            }

            var _activeProgressBar;

            $("#_progressDialog").on(
                "shown",
                function () {
                    _activeProgressBar = setInterval(function () {
                        var maxWidth = parseInt($("#_progressDialogBar")
                            .parent().css("width"), 10);
                        var width = parseInt($("#_progressDialogBar").css(
                            "width"), 10);
                        if (width < maxWidth) {
                            var persent = width / maxWidth + 0.1;

                            $("#_progressDialogBar").css("width",
                                maxWidth * persent + "px");
                        } else {
                            $("#_progressDialogBar").css("width", "0px");
                        }

                    }, 700);
                });

            $("#_progressDialog").on("hidden", function () {
                $("#_progressDialogBar").css("width", "0%");
                window.clearInterval(_activeProgressBar);
            });

            cwnd.show();
        },
        alertInfo: function (text, title) {
            var attr = new Object();
            attr.type = "info";
            attr.title = title;
            attr.text = text;
            $.dialog.alert(attr);
        },
        alertError: function (text, title) {
            var attr = new Object();
            attr.type = "error";
            attr.title = title;
            attr.text = text;
            $.dialog.alert(attr);
        },
        alertSuccess: function (text, title, closeFunc) {
            var attr = new Object();
            attr.type = "success";
            attr.title = title;
            attr.text = text;
            attr.closeFunc = closeFunc;
            $.dialog.alert(attr);
        },
        alert: function (options) {

            if ($.utils.isEmpty(options.title)) {
                if (options.type == "success") {
                    options.title = "成功提示";
                } else if (options.type == "error") {
                    options.title = "错误提示";
                } else {
                    options.title = "信息提示";
                }
            }

            var cwnd = new CWnd({
                id: "_alertDialog",
                title: options.title,
                width: 400,
                height: 60,
                cls: "alert-" + options.type,
                body: "<p>" + options.text + "</p>",
                foot: '<a class="btn" data-dismiss="modal">确定</a>'
            });

            if ($.utils.isEmpty(options.closeFunc)) {
                $("#_alertDialog").unbind("hidden");
            } else {
                $("#_alertDialog").on("hidden", options.closeFunc);
            }

            cwnd.show();
        },
        confirm: function (text, title, func) {
            if ($.utils.isEmpty(func)) {
                func = title;
                title = "确认窗口";
            }

            var cwnd = new CWnd({
                id: "_confirmDialog",
                title: title,
                width: 400,
                height: 60,
                cls: "alert-info",
                body: "<p>" + text + "</p>",
                foot: '<a class="btn btn-primary" data-dismiss="modal">确定</a>'
                    + '<a class="btn" data-dismiss="modal">关闭</a>'
            });

            $("#_confirmDialog .modal-footer .btn-primary").on("click", func);
            cwnd.show();
        }
    };

    $.fn.formDialog = function (options) {

        var _formId = $(this).attr("id");
        var _dialogId = "_formDialog_" + _formId;
        var _form = $(this);

        var _method = {
            show: function (title) {
                if (!$.utils.isEmpty(title)) {
                    $("#" + _dialogId + " > .modal-header > h4").html(title);
                }
                $("#" + _dialogId).modal("show");
            },
            close: function () {
                $("#" + _dialogId).modal("hide");
            },
            init: function (options) {
                var defaults = {
                    title: "",
                    buttons: [
                        {
                            text: "关闭",
                            cls: "",
                            closed: true,
                            click: function () {
                                $("#" + _dialogId).modal("hide");
                            }
                        }
                    ]
                };

                var options = $.extend(defaults, options);

                var _body = $.utils.toString($("#" + _formId));
                _form.remove();

                var _foot = $("<div></div>");
                for (var i = 0; i < options.buttons.length; i++) {

                    var btn = options.buttons[i];

                    var _btn = $('<button type="button" class="btn"></button>');
                    _btn.html(btn.text);
                    _btn.addClass(btn.cls);

                    if (!$.utils.isEmpty(btn.closed) && btn.closed == true) {
                        _btn.attr("data-dismiss", "modal");
                        _btn.addClass("btn-default");
                    }

                    if (!$.utils.isEmpty(btn.click)) {
                        _btn.click(btn.click);
                    }

                    _foot.append(_btn);
                }

                new CWnd({
                    id: _dialogId,
                    title: options.title,
                    body: _body,
                    foot: _foot,
                    height: options.height,
                    width: options.width
                });
            }
        };

        if ($.utils.isEmpty(options)) {
            options = "show";
        }

        if (typeof options == "string") {

            if (arguments.length > 1) {
                _method[options](arguments[arguments.length - 1]);
            } else {
                _method[options]();
            }

            return;
        } else {
            _method["init"](options);
        }
    };

})(jQuery);