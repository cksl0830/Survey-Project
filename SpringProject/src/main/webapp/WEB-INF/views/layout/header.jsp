<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<nav class="navbar navbar-expand-xl">
<div class="container h-100">
	<a class="navbar-brand" href="main">
		<img src="${pageContext.request.contextPath}/resources/logo/logo3.PNG" alt="logo" class="title-logo" style="height: 80px"/>
	</a>
	<button class="navbar-toggler ml-auto mr-0" type="button"
		data-toggle="collapse" data-target="#navbarSupportedContent"
		aria-controls="navbarSupportedContent" aria-expanded="false"
		aria-label="Toggle navigation">
		<i class="fas fa-bars tm-nav-icon"></i>
	</button>
	<div class="collapse navbar-collapse" id="navbarSupportedContent">
		<ul class="navbar-nav mx-auto h-100">
			<li class="nav-item"><a class="nav-link" href="main?progressing=1">
					<i class="fas fa-file-alt"></i> 설문조사 시작
			</a></li>
			<li class="nav-item"><a class="nav-link" href="main?progressing=0">
					<i class="fas fa-chart-pie"></i> 결과 분석
			</a></li>
			<c:if test="${ not empty pageContext.request.userPrincipal }">
				</a></li>
				<s:authorize ifAllGranted="ROLE_ADMIN">
					<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath() %>admin">
							<i class="far fa-eye"></i> 관리자페이지
					</a></li>
				</s:authorize>
			</c:if>
		</ul>
		<ul class="navbar-nav">
			<c:if test="${ empty pageContext.request.userPrincipal }">
				<li class="nav-item"><a class="nav-link d-block"
					href="login"> <i class="fas fa-sign-in-alt"></i> 로그인</a></li>
				<li class="nav-item"><a class="nav-link d-block"
					href="join"> <i class="fas fa-check"></i> 회원가입
				</a></li>
			</c:if>
			<c:if test="${ not empty pageContext.request.userPrincipal }">
				<li class="nav-item"><a class="nav-link" href="logout">
					<i class="fas fa-sign-out-alt"></i> 로그아웃
					</a>
				</li>

				<li class="nav-item dropdown">
					<a class="nav-link" id="dLabel" role="button" data-toggle="dropdown" data-target="#"
						href="/page.html"> 
						<i class="fas fa-bell"></i>알림
						<span class="label label-warning" style="color:white">0</span>
					</a>
					<ul class="dropdown-menu notifications" role="menu"
						aria-labelledby="dLabel" style="left: -200px; position: absolute;">

						<div class="notification-heading">
							<h2 class="tm-block-title" style="margin-bottom: 0px;">알림</h2>
						</div>
						<li class="divider"></li>

						<div id="notifications-current" class="notifications-wrapper">
						</div>


						<div id="notifications-past" class="notifications-wrapper" style="display: none">
						</div>
						
						<li class="divider"></li>
						<div class="notification-footer">
							<p id="change-notice" class="notice-current" style="float: right; cursor: pointer; margin: 0">지난 알림보기</p>
						</div>
					</ul>

				</li>
			</c:if>
		</ul>
	</div>
</div>
</nav>

<script id="sampleData" type="text/x-jQuery-tmpl">
  <a class="content" href="{{= url}}">
  	<div class="media notification-item">
  		<div class="tm-gray-circle-small">
  			<img src="{{= img}}" alt="Avatar Image" class="rounded-circle-small">
  		</div>
  		<div class="media-body">
  			<p class="mb-2">{{= message}}</p>
  			<span class="tm-small tm-text-color-secondary">{{= username}}</span>
  		</div>
  	</div>
  </a>
</script>
<c:if test="${ not empty pageContext.request.userPrincipal }">
	<link rel="stylesheet" href="/resources/css/nav_notice.css"/>
	<script src="/resources/js/nav_notice.js"></script>
	<script>
		var login_member_seq = ${ pageContext.request.userPrincipal.principal.member_seq };
		getNoticeCount(login_member_seq);
		setInterval(function() {
			getNoticeCount(login_member_seq)
		}, 40000)
		
		$(".nav-link").on("click", function() {
			$.ajax({
				url : "getUserNotice",
				dataType : "json",
				cache: false,
				data : {
					member_seq : login_member_seq
				},
				success : function(ret) {
					$("#notifications-current").empty();
					$("#notifications-past").empty();
					
					for(var i=0; i<ret.length; i++) {
						if (ret[i].notice_readdate==null || ret[i].notice_readdate=="" ){
							$('#sampleData').tmpl([
								{ 	 url:'/survey/readSurvey?survey_seq='+ret[i].survey_seq+'&amp;progressing='+ret[i].progressing 
								   , img: '/resources/img/'+ret[i].usimage
								   , message: ret[i].notice_message
								   , username: ret[i].notice_regdate }
								]).appendTo('#notifications-current');	
						} else {
							$('#sampleData').tmpl([
								{    url:'/survey/readSurvey?survey_seq='+ret[i].survey_seq+'&amp;progressing='+ret[i].progressing
								   , img: '/resources/img/'+ret[i].usimage
								   , message: ret[i].notice_message
								   , username: ret[i].notice_regdate }
								]).appendTo('#notifications-past');	
						}
						
					}
					itemsMax = $('#notifications-past a').length;
					itemsCount = 0;
					$('#notifications-past a').hide();
					showNextItems();
				
				}
			});
		});
	
	var itemsCount, itemsMax;
	
	$('#notifications-past').on('scroll', function() {
        if($(this).scrollTop() + $(this).innerHeight() + 10 >= $(this)[0].scrollHeight) {
        	showNextItems();
        }
    })
	
	function showNextItems() {
	    var pagination = 4;
	    
	    for (var i = itemsCount; i < (itemsCount + pagination); i++) {
	        $('#notifications-past a:eq(' + i + ')').show();
	    }

	    itemsCount += pagination;
	    if (itemsCount > itemsMax) {
	        $('#showMore').hide();
	    }
	};
	</script>
</c:if>
