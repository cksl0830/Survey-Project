// Default settings
var noticePopupTimer = setTimeout(function () {}, 1);
var noticePopupDefaultOption = {
    id: 'default',
    message: '기본 메시지 입니다.',
    padding: '20px 40px',
    fade: 500,
    duration: 1500,
    beforeShow: function () {},
    complete: function() {}
};

function noticePopupInit(options) {
    // Set Options
    var settings = $.extend(
        {}, 
        noticePopupDefaultOption, 
        options);
    $("div.noticePopup").attr("id", settings.id);

    var element = "div#" + settings.id + ".noticePopup";
    // Set Style
    $(element).css("padding", settings.padding);
    // Set Message
    $(element + ">div.noticeMessage").html(settings.message);

    // Set Position
    var width = $(element).outerWidth();
    var height = $(element).outerHeight();
    $(element).css("margin-left", String(-width / 2) + "px");
    $(element).css("margin-top", String(-height / 2) + "px");

    // Clear Animation
    $(element).stop();
    clearTimeout(noticePopupTimer);
    $(element).css("display", "none");

    // Start Animation
    $(element).fadeIn(settings.fade, function () {
        noticePopupTimer = setTimeout(function () {
            $(element).fadeOut(settings.fade);
        }, settings.duration, settings.complete());
    });
}