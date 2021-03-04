$("#change-notice").on("click", function() {
	if ($(this).attr("class") == "notice-current") {
		$(this).attr("class", "notice-past");
		$(this).html("현재 알림보기");
		$("#notifications-current").attr("style", "display: none")
		$("#notifications-past").attr("style", "display: block")
	}
	else {
		$(this).attr("class", "notice-current");
		$(this).html("지난 알림보기");
		$("#notifications-current").attr("style", "display: block")
		$("#notifications-past").attr("style", "display: none")
	}
});

function getNoticeCount(mem_seq) {
	$.ajax({
		url : "checkUserNotice",
		dataType : "json",
		cache: false,
		data : {
			member_seq : mem_seq
		},
		success : function(ret) {
			if (ret != 0) { //false반환시 이미 ID가 있는 상황
				$("#dLabel > span").html(ret.result);
			}
		}
	});
}

/*function getUserNotice(member_seq, time) {
	$.ajax({
		url : "getUserNotice",
		dataType : "json",
		cache: false,
		data : {
			member_seq : mem_seq,
			type : time // past이거나 cur
		},
		success : function(ret) {
			if (ret != 0) { //false반환시 이미 ID가 있는 상황
				$("#dLabel > span").html(ret.result);
			}
		}
	});
}*/
