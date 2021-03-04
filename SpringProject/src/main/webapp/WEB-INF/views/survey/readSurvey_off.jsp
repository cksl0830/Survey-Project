<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="container mt-5">
	<div class="row tm-content-row">
		<div class="col-xl-6 tm-block-col ">
			<div class="tm-bg-primary-dark tm-block tm-block-settings">
				<div class="form-group col-lg-4">
					<label for="Title">Title</label>
				</div>
				<div class="form-group col-lg-8">
					<label for="TitleEL">${ survey.title }</label>
				</div>
				<hr class="show-hr" width="100%">
				<div class="form-group col-lg-4">
					<label for="Writer">Writer</label>
				</div>
				<div class="form-group col-lg-8">
					<label for="WriterEL">${ survey.name }</label>
				</div>
				<hr class="show-hr" width="100%">
				<div class="form-group col-lg-4">
					<label for="Period">기간</label>
				</div>
				<div class="form-group col-lg-8">
					<label for="PeriodEL"> <fmt:formatDate
							value="${ survey.reg_date }" pattern="yy-MM-dd" /> ~ <fmt:formatDate
							value="${ survey.end_date }" pattern="yy-MM-dd" />
					</label>
				</div>
				<hr class="show-hr" width="100%">
				<div class="col-12">
					<div class="tm-bg-primary-dark tm-block tm-block"
						style="padding: 0; height: 300px">
						<h2 class="tm-block-title" style="padding: 0">
						투표 결과
						</h2>
						<c:if test=""></c:if>
						<canvas id="pieChart" class="chartjs-render-monitor" width="200"
							height="200"></canvas>
					</div>
					<h2 class="tm-block-title">목록</h2>
					<div class="form-group col-lg-12">
						<c:forEach items="${ survey.surveyItemList }" var="item" varStatus="status">
							<label class="tm-hide-sm"><span>${ status.count } - ${ item.content }</span></label><br>
						</c:forEach>
					</div>
				</div>
				<span class="form-group col-lg-3" style="padding: 10px">
					<c:if test="${ survey.member_seq eq pageContext.request.userPrincipal.principal.member_seq}">
						<button type="submit" id="surveyClose" class="btn btn-primary text-uppercase btn-show" style="float:left; margin-right: 4px;">삭제</button>
					</c:if>
					<button type="button" id="surveyHome" class="btn btn-primary text-uppercase btn-show" style="float:right;">홈</button>
				</span>
			</div>
		</div>
		<div class="col-xl-6 tm-block-col ">
			<div class="tm-bg-primary-dark tm-block tm-block-settings">
				<div>
					<h2 class="tm-block-title">성별 투표결과</h2>
					<canvas id="lineChart"></canvas>
				</div>
				<div style="padding-top: 40px">
					<h2 class="tm-block-title">나이별 투표결과</h2>
					<canvas id="barChart"></canvas>
				</div>
				<div style="padding: 30px"></div>
				<div class="tm-bg-primary-dark tm-block tm-block-taller tm-block-overflow" style="padding:10px">
                       <h2 class="tm-block-title">Reply board</h2>
                       <div id="mydiv" class="tm-notification-items">
                           <div class="media tm-notification-item">
                               <div style="width:100%">
                               	<textarea class="reply-text" type="text" style="width: 100%;height: 100px;word-wrap: break-word;"></textarea>
                               	<br>
                               	<button type="button" class="btn-reply" style="width: 100%; color: #fff; background-color: #f5a623; border: 2px solid #f5a623;" >댓글입력</button>
                               </div>
                           </div>
                           
                           <c:forEach items="${ reply }" var="dto" varStatus="status">
						
                            <div class="media tm-notification-item">
   	                            <c:if test="${empty dto.image}">
   	                            	<img src="/resources/img/default_profile.png" alt="Avatar Image" class="rounded-circle-small" style="margin-right: 10px;">
   	                            </c:if>
   	                            <c:if test="${not empty dto.image}">
   	                            	<img src="/resources/img/${dto.image}" alt="Avatar Image" class="rounded-circle-small" style="margin-right: 10px;">
   	                            </c:if>
       	                        <div class="media-body">
           	                        <p class="mb-2"><h4>${dto.username}</h4><b>${dto.reply_msg}</b> </p>
               	                    <span class="tm-small tm-text-color-secondary">${dto.writetime}  </span>
               	                    <c:if test="${pageContext.request.userPrincipal.name eq dto.username}">
                	                    <button type="button" class="reply_edit" 
   	            	                    	data-username="${dto.username}"
       	        	                    	data-replyseq="${dto.reply_seq}" 
       	        	                    	style="background-color: #4CAF50; border: none; color: white; padding:3px 8px">수정</button>
       	        	                    <button type="button" class="reply_del" 
   	            	                    	data-username="${dto.username}"
       	        	                    	data-replyseq="${dto.reply_seq}"
       	        	                    	style="background-color: #4CAF50; border: none; color: white; padding:3px 8px">삭제</button>    	                    
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
<script src="/resources/js/Chart.min.js"></script>
<script src="/resources/js/tooplate-scripts.js"></script>
<script>
	$("#surveyHome").on("click", function() {
		event.preventDefault();
		location.href = "/survey/main${cri.makeSearch()}";
	});

	Chart.defaults.global.defaultFontColor = 'white';
	let ctxLine, ctxBar, ctxPie, optionsLine, optionsBar, optionsPie, configLine, configBar, configPie, lineChart;
	barChart, pieChart;
	// DOM is ready
	var dataset = ${dataset};
	var itemList = ${itemList};
	$(function() {
		drawLineChart(dataset, itemList); // Line Chart
		drawBarChart(dataset, itemList); // Bar Chart
		drawPieChart(dataset, itemList); // Pie Chart

		$(window).resize(function() {
			updateLineChart();
			updateBarChart();
			updatePieChart();
		});
	})
	var count = getTotalCountList(dataset, itemList);
	if (count.length != 0) {
		$.each($("label.tm-hide-sm"), function(index) {
			$(this).append(" [ <i class='fa fa-fw fa-tags'></i>&nbsp;" + count[index]===undefined?'0':'' + "표 ] ")
		});
	} else {
		$.each($("label.tm-hide-sm"), function(index) {
			$(this).append(" [ <i class='fa fa-fw fa-tags'></i>&nbsp; 투표결과X ] ")
		});
	}

	//댓 edit
	$(".reply_edit").click(function() {
		$("#reply-edit").remove();
		var replyseq = $(this).data("replyseq");
		var oldmsg = $(this).parent().find("b").first();
		console.log(replyseq);
		var btag = $(this).parent();
		$(this).parent().find("b").first().append(
						"<div id='reply-edit' style='width:100%'><textarea class='reply-edit-text' type='text' style='width: 100%;height: 50px;word-wrap: break-word;'></textarea><br><button type='button' class='btn-reply_edit'"
								+ "data-replyseq_c='"
								+ replyseq
								+ "' "
								+ "style='width: 100%; color: #fff; background-color: #f5a623; border: 2px solid #f5a623;' >댓글수정</button></div>");

		$(".btn-reply_edit").click(function(event) {

			var reply_seq = $(this).data("replyseq_c");
			var survey_seq = ${param.survey_seq};
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