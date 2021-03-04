<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>
<div class="container mt-5">
	<div class="row tm-content-row">
		<div class="col-sm-12 col-md-12 col-lg-8 col-xl-8 tm-block-col tm-col-account-settings-show">
			<div class="tm-bg-primary-dark tm-block tm-block-settings">
				<form id="voteform" method="post" class="tm-signup-form row"> <!-- action 추가 ?? 생략 ??-->
					<input type="hidden" id="survey_seq" name="survey_seq" value="${survey.survey_seq}">
					<div class="form-group col-lg-2 fa-2x">
						<label class="tm-block-title" for="Title">Title</label>
					</div>
					<div class="form-group col-lg-10">
						<label for="TitleEL">${ survey.title }</label>
					</div>
					<hr class="show-hr" width="100%">
					<div class="form-group col-lg-2">
						<label class="tm-block-title" for="Writer">Writer</label>
					</div>
					<div class="form-group col-lg-10">
						<label for="WriterEL">${ survey.name }</label>
					</div>
					<hr class="show-hr" width="100%">
					<div class="form-group col-lg-2">
						<label class="tm-block-title" for="Period">기간</label>
					</div>
					<div class="form-group col-lg-10">
						<label for="PeriodEL"> 
						<fmt:formatDate value="${ survey.reg_date }" pattern="yy-MM-dd" /> 
						~ <fmt:formatDate value="${ survey.end_date }" pattern="yy-MM-dd" />
						</label>
					</div>
					<hr class="show-hr" width="100%">
					<div class="col-12">
						<h2 class="tm-block-title">목록</h2>
						<div class="form-group col-lg-12">
							<!-- 동적으로 설문지 보기 생성 or 그래프 출력 -->
							<c:forEach items="${ survey.surveyItemList }" var="item" varStatus="status">
								<label class="tm-hide-sm">
									<span style="vertical-align: super;">${ status.count } - ${ item.content }</span>
									&nbsp;&nbsp;
									<input name=itemSeq type="radio"
									class="form-control validate" value="${ item.survey_item_seq }"
									style="display: inline-block">
								</label><br>
							</c:forEach>
						</div>
					</div>
					<div class="form-group col-lg-12">
						<c:choose>
							<c:when test="${ survey.member_seq eq pageContext.request.userPrincipal.principal.member_seq }">
								<button type="submit" id="surveyClose" class="btn btn-primary text-uppercase btn-show" style="float:left; margin-right: 4px;">마감</button>
							</c:when>
							<c:otherwise>
							<s:authorize ifAllGranted="ROLE_ADMIN">
								<button type="button" id="surveyClose" class="btn btn-primary text-uppercase btn-show" style="float:left; margin-right: 4px;">마감</button>
							</s:authorize>
							</c:otherwise>
						</c:choose>	
						<c:if test="${ survey.member_seq eq pageContext.request.userPrincipal.principal.member_seq}">
							<button type="button" id="surveyRemove" class="btn btn-primary text-uppercase btn-show">삭제</button>
						</c:if>
						<button type="button" id="surveyVote" class="btn btn-primary text-uppercase btn-show" style="float:right;">투표</button>
						<button type="button" id="surveyHome" class="btn btn-primary text-uppercase btn-show" style="float:right; margin-right: 4px">홈</button>
					</div> 
				</form>
				
			</div>
			
		</div>
		<div class="col-sm-12 col-md-12 col-lg-4 col-xl-4 tm-block-col">
			<div class="tm-bg-primary-dark tm-block tm-block-taller tm-block-overflow" style="padding: 10px">
					<h2 class="tm-block-title">Reply board</h2>
					<div id="mydiv" class="tm-notification-items">
						<div class="media tm-notification-item">
							<div style="width: 100%">
								<textarea class="reply-text" type="text"
									style="width: 100%; height: 100px; word-wrap: break-word;"></textarea>
								<br>
								<button type="button" class="btn-reply"
									style="width: 100%; color: #fff; background-color: #f5a623; border: 2px solid #f5a623;">댓글입력</button>
							</div>
						</div>
						<c:forEach items="${ reply }" var="dto" varStatus="status">
							<div class="media tm-notification-item">
								<c:if test="${empty dto.image}">
									<img src="/resources/img/default_profile.png"
										alt="Avatar Image" class="rounded-circle-small"
										style="margin-right: 10px;">
								</c:if>
								<c:if test="${not empty dto.image}">
									<img src="/resources/img/${dto.image}" alt="Avatar Image"
										class="rounded-circle-small" style="margin-right: 10px;">
								</c:if>
								<div class="media-body">
									<p class="mb-2">
									<h4>${dto.username}</h4>
									<b>${dto.reply_msg}</b>
									</p>
									<span class="tm-small tm-text-color-secondary">${dto.writetime}
									</span>
									<c:if
										test="${pageContext.request.userPrincipal.name eq dto.username}">
										<button type="button" class="reply_edit"
											data-username="${dto.username}"
											data-replyseq="${dto.reply_seq}"
											style="background-color: #4CAF50; border: none; color: white; padding: 3px 8px">수정</button>
										<button type="button" class="reply_del"
											data-username="${dto.username}"
											data-replyseq="${dto.reply_seq}"
											style="background-color: #4CAF50; border: none; color: white; padding: 3px 8px">삭제</button>
									</c:if>
								</div>
							</div>

						</c:forEach>
					</div>
				</div>
		</div>
	</div>
</div>
</div>
<script>
	$("#surveyHome").on("click", function() {
		event.preventDefault();
		location.href = "/survey/main${cri.makeSearch()}";
	});

	$("#surveyVote").on("click", function(event) {
		event.preventDefault();

		var form = $("#voteform")[0];
		var formData = new FormData(form);

		$.ajax({
			url : '/survey/voteSurvey',
			processData : false,
			contentType : false,
			data : formData,
			type : "POST",
			cache : false,
			success : function(ret) {
				if (!ret.result) {
					noticePopupInit({
						message : ret.message,
					});
				} else {
					noticePopupInit({
						message : ret.message,
						complete : setTimeout(function() {
							location.href = "/survey/main";
						}, 3000)
					});

				}
			},
			error : function() {
				noticePopupInit({
					message : "서버 에러. 잠시후에 시도하세요"
				});
			}
		});
	});

	$("#surveyClose").on("click", function() {
		event.preventDefault();
		var result = confirm("설문을 마감하시겠습니까?");

		if (result) {
			var form = $("#voteform")[0];
			$(form).attr("action", "/survey/closeSurvey");
			$(form).submit();
		}
	});

	$("#surveyRemove").on("click", function() {
		event.preventDefault();

		var result = confirm("설문을 삭제하시겠습니까?");

		if (result) {
			var form = $("#voteform")[0];
			$(form).attr("action", "/survey/removeSurvey");
			$(form).submit();
		}
	});
</script>
<script>
//댓 edit
$(".reply_edit").click(
function() {
	$("#reply-edit").remove();
	var replyseq = $(this).data("replyseq");
	var oldmsg = $(this).parent().find("b").first();
	console.log(replyseq);
	var btag = $(this).parent();
	$(this)
		.parent()
		.find("b")
		.first()
		.append(
				"<div id='reply-edit' style='width:100%'><textarea class='reply-edit-text' type='text' style='width: 100%;height: 50px;word-wrap: break-word;'></textarea><br><button type='button' class='btn-reply_edit'"
						+ "data-replyseq_c='"
						+ replyseq
						+ "' "
						+ "style='width: 100%; color: #fff; background-color: #f5a623; border: 2px solid #f5a623;' >댓글수정</button></div>");

	$(".btn-reply_edit").click(function(event) {

		var reply_seq = $(this).data("replyseq_c");
		var survey_seq = ${param.survey_seq}
		;
		var reply_msg = $(".reply-edit-text").val();

		$.ajax({
			url : "replyUpdate",
			method : 'post',
			dataType : 'json',
			data : {
				"reply_seq" : reply_seq,
				"survey_seq" : survey_seq,
				"reply_msg" : reply_msg
			},
			success : function(res) {
				if (res) {
					noticePopupInit({
						message : "댓글이 수정되었습니다."
					});
					$("#reply-edit").remove();
					var x = btag.find("b");
					$(x).first().html(reply_msg);
				}
			}
		});
	});
});

//댓글 ajax

$(".btn-reply").click(function(event) {
	var username = '${pageContext.request.userPrincipal.name}';
	if (username == '') {
		noticePopupInit({
			message : "로그인이 필요합니다."
		});
		return;
	}
	var reply_msg = $(".reply-text").val();
	var survey_seq = ${param.survey_seq};

	var posting = $.post("replyInsert", {
		username : username,
		reply_msg : reply_msg,
		survey_seq : survey_seq
	});
	location.reload();
});

//댓 삭제
$(".reply_del").click(function(event) {
	if (confirm("해당 댓글을 삭제하시겠습니까?")) {
		var reply_seq = $(this).data("replyseq");
		var survey_seq = ${param.survey_seq};
		var del = $(this);
		$.ajax({
			url : "replyDel",
			method : 'post',
			dataType : 'json',
			data : {
				"reply_seq" : reply_seq,
				"survey_seq" : survey_seq
			},
			success : function(res) {
				if (res) {
					noticePopupInit({
						message : "댓글이 삭제되었습니다."
					});
					del.parent().parent().remove();
				}
			}
		});
	}
});
</script>