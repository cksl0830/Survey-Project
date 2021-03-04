<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<div class="container mt-5">
	<!-- row -->
	<div class="row tm-content-row">
		<div class="tm-block-col tm-col-avatar">
			<div class="tm-bg-primary-dark tm-block tm-block-avatar">
				<h2 class="tm-block-title">Change Avatar</h2>
				<div class="tm-avatar-container">
					<img src="/resources/img/default_profile.png" alt="Avatar" class="tm-avatar img-fluid mb-4"
						id="profile-image" />
					<a href="#" class="tm-avatar-delete-link">
						<i class="far fa-trash-alt tm-product-delete-icon"></i>
					</a>
				</div>
				<button class="btn btn-primary btn-block text-uppercase upload-button"> 사진 업로드</button>
			</div>
		</div>
		<div class="tm-block-col tm-col-account-settings">
			<div class="tm-bg-primary-dark tm-block tm-block-settings">
				<h2 class="tm-block-title">회원가입</h2>
				<form class="tm-signup-form row" method="post" enctype="multipart/form-data">
					<input type="file" id="profile-image-input" name="image" style="display: none">
					<div class="form-group col-lg-12">
						<label for="username">아이디</label>&nbsp;&nbsp;<span id="checkid"></span>
						<input id="username" name="username" type="text" class="form-control validate"
							isvalid="false" />
					</div>
					<div class="form-group col-lg-12">
						<label for="email">이메일</label>&nbsp;&nbsp;<span id="checkid"></span>
						<input id="email" name="email" type="text" class="form-control validate"
							isvalid="false" />
					</div>
					<div class="form-group col-lg-6">
						<label for="password">비밀번호</label>
						<input id="password" name="password" type="password" class="form-control validate"/>
					</div>
					<div class="form-group col-lg-6">
						<label for="password2">비밀번호 확인</label>&nbsp;&nbsp;<span id="checkpw"></span>
						<input id="password2" name="password2" type="password" isvalid="false"
							class="form-control validate" />
					</div>
					<div class="form-group col-lg-6">
						<label for="name">이름</label>
						<input id="name" name="name" type="text" class="form-control validate"/>
					</div>
					<div class="form-group col-lg-6">
						<label for="birth-str">생일 </label>
						<input type='text' class='datepicker-here form-control validate' name="birth" autocomplete=off/>
						<!-- <input name="birth" type='date' class="form-control validate" /><br> -->
					</div>
					<div class="form-group col-lg-6">
						<label for="gender">성별</label><br>
						<label for="gender" style="vertical-align: middle;">남</label>
						<input name="gender" type="radio" checked="checked" class="form-control validate"
							value="male" style="display: inline-block" />
						&nbsp; &nbsp; &nbsp; &nbsp;
						<label for="gender" style="vertical-align: middle;">여</label>
						<input name="gender" type="radio" class="form-control validate" value="female"
							style="display: inline-block" />
					</div>
					<div class="form-group col-lg-6">
						<label class="tm-hide-sm">&nbsp;</label>
						<button type="submit" id="btn_submit"
							class="btn btn-primary btn-block text-uppercase">확인</button>
						<button id="btn_cancle" class="btn btn-primary btn-block text-uppercase">취소</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<script>
$(".tm-avatar-delete-link").on("click", function() {
	$(".tm-avatar").attr("src", "/resources/img/default_profile.png");
	/* document.getElementById("profile-image-input").select();
	document.selection.clear(); */
	var input = document.getElementById("profile-image-input");
	input.value = ''
	if(!/safari/i.test(navigator.userAgent)){
	  input.type = '';
	  input.type = 'file';
	}
});
</script>
<script>
	var upload = document.getElementById("profile-image-input");
	var img = document.getElementById("profile-image");
	
	$(".upload-button").on("click", function () {
		upload.click();
	});
	upload.onchange = function (e) {
		e.preventDefault();
		var file = upload.files[0];
		var reader = new FileReader();
		reader.onload = function (event) {
			img.src = event.target.result;
		};
		reader.readAsDataURL(file);
		return false;
	}
</script>
<script>
	$("#btn_cancle").one("click", function (event) {
		event.preventDefault();
		location.href = "/survey/main"
	});
	$("#username").on("blur", function(event) { //id중복 체크를 위해 blur시에 ajax로 id값 전달 및 반환값 출력
		var id_input = $(this);
		if ($(id_input).val() == '') {
			noticePopupInit({
				message : "ID를 입력하세요"
			});
			$("#checkid").html("ID를 입력하세요");
			$(id_input).attr("isvalid", false).css("color","blue");
			return;
		}
		$.ajax({
			url : "checkUsername",
			dataType : "json",
			cache: false,
			data : {
				"username" : $(id_input).val()
			},
			success : function(ret) {
				noticePopupInit({
					message : ret.message
				});
				if (!ret.result) { //false반환시 이미 ID가 있는 상황
					$(id_input).attr("isvalid", false);
					$("#checkid").html(ret.message).css("color","red");
				}
				else {
					$(id_input).attr("isvalid", true);
					$("#checkid").html(ret.message).css("color","blue");
				}
			},
			
			error: function () {
				noticePopupInit({
					message : "서버 에러. 잠시후에 시도하세요"
				});
				$("#checkid").html("서버 에러... 잠시후에 시도하세요").css("color","red");
			}
		});
	});
	
	$("#password2").on("blur", function(event) {
		var password = $("#password").val();
		var password2 = $(this).val();
		
		if (password != password2) {
			noticePopupInit({
				message : "비밀번호가 일치하지 않습니다."
			});
			$("#checkpw").html("비밀번호가 일치하지 않습니다.").css("color","red");
			$(this).attr("isvalid", false);
		}
		else {
			$("#checkpw").html("비밀번호가 일치합니다.").css("color","blue");
			$(this).attr("isvalid", true);
		}
	});
	$("#btn_submit").on("click", function (event) {
		event.preventDefault();
		var inputs = $("input[type='text'], input[type='password'], input[type='date']"); //유효성 체크할 id, pw, date를 가져옴
		var result = false;
		$.each($(inputs), function( index, value ) {
			if ($(value).val() == '' ) {
				noticePopupInit({ 
					message:'모든 값을 입력해주세요.' 
				});
				$(value).focus();
				result = false;
				return false;
			}
			result = true;
			return;
		}); //만약 해당 input태그에 값이 없을 경우 focus하고 빠져나옴
		if (!result) {
			return;
		}
		
		$.each($("input[isvalid]"), function( index, value ) {
			if (!$(value).attr("isvalid")) {
				noticePopupInit({
					message:'정확한 값을 입력해주세요.' 
				});
				$(value).focus();
				result = false;
				return false;
			}
			result = true;
			return;
		}); //값이 있는 대신 id가 중복된 아이디거나 pw가 일치하지 않으면 focus하고 빠져나옴
		if (result) { //모든 유효성을 통과했다면 submit
			var formtag = $(".tm-signup-form"); 
			$(formtag).submit();
		}
	}); 
</script>