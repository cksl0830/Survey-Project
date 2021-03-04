<%@ page language="java" contentType="text/html; charset=UTF-8"                                                                                                                                                           
	pageEncoding="UTF-8"%>
<script type="text/javascript">
    $(document).ready(function () {

        $('.addq_btn').on('click', function () {
        	 var q = $("<div class='q'><span></span> <input id='name' autocomplete='off' name='itemcontent' type='text' "
			                +"class='form-control littleq'> <button type='button' class='minusq_btn'><b> x</b></button></div>"
			                );
            $(this).parent().find('.qbox').append(q);
        });

        $(document).on('click', '.minusq_btn', function () {
				 $(this).parent().remove();
        });

        $(document).on('click', 'button', function () {
            $('.addsurveybox').find('.q').each(function (i) {
                $(this).find('span').text(i + 1);
            });
        });

/*         $("#expire_date").on("focusout", function(){
        	var now = new Date().format("yyyyMMdd");
        	var ed=$("#expire_date").val()
        	
        	var edate=ed.split("/")[0]+ed.split("/")[1]+ed.split("/")[2];
        	if(eval(edate-now)<=0) 
        		{alert("마감기한은 현재날짜 같거나,이전일 수 없습니다...");
        			$("#expire_date").val("");}
        	if(ed==null){alert("마감기한을 설정하지않으면 설문을 등록할 수 없습니다..");}
        	else alert("날짜설정잘했어요");

        }); */

		$("#submit_btn").on("click",function(event){
			event.preventDefault();
		    var ed=$("#expire_date").val();
		    var offset=$("#expire_date").offset();
        	if(ed==""){
        					$("#expire_date").attr("style","border:solid 2px pink");
        					$('html, body').animate({scrollTop : offset.top-100}, 2000);
        					noticePopupInit({message:"마감기한을 설정하지않으면 설문을 등록할 수 없습니다.."});
        					}
        	else{
					var now = new Date().format("yyyyMMdd");
		        	var edate=ed.split("/")[0]+ed.split("/")[1]+ed.split("/")[2];
		        	var interval=eval(edate-now);
		        	if(interval<=0){ 
		        		$("#expire_date").attr("style","border:solid 2px pink");
    					$('html, body').animate({scrollTop : offset.top-100}, 2000);
		        		noticePopupInit({message:"마감기한은 현재날짜와 같거나,이전일 수 없습니다..."});
		        		$("#expire_date").val("");
		        		}
		        	if(interval>=1){
		        		//alert(interval);
			        	noticePopupInit({message:"설문등록중입니다^^"});
			        	$("#addSurveyForm").submit();
        			}
        	}
		});
        
        $(".tm-avatar-delete-link").on("click", function() {
        	$(".tm-avatar").attr("src", "/resources/img/default_survey.png");
        	/* document.getElementById("profile-image-input").select();
        	document.selection.clear(); */
        	var input = document.getElementById("profile-image-input");
        	input.value = ''
        	if(!/safari/i.test(navigator.userAgent)){
        	  input.type = '';
        	  input.type = 'file';
        	}
        })

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
    
    });
</script>


    <div class="container tm-mt-big tm-mb-big">
    <form action="/survey/addSurvey" method="post" enctype="multipart/form-data"
    class="tm-edit-product-form" id="addSurveyForm">
        <div class="row">
            <div class="col-xl-9 col-lg-10 col-md-12 col-sm-12 mx-auto">
                <div class="tm-bg-primary-dark tm-block tm-block-h-auto">
                    <div class="row">
                        <div class="col-12">
                            <h2 class="tm-block-title d-inline-block">설문지 등록하기</h2>
                        </div>
                    </div>
                    <div class="row tm-edit-product-row">
                        <div class="col-xl-6 col-lg-6 col-md-12 bigbox">

                            <div class="tm-bg-primary-dark tm-block tm-block-avatar">
                                <h2 class="tm-block-title" align="center">설문조사 관련 이미지파일 업로드</h2>
                                <div  class="tm-avatar-container" align="left">
                                    <img  style="width:30%"
                                    	src="/resources/img/default_survey.png" alt="Avatar"
                                        class="tm-avatar img-fluid mb-4" id="profile-image"> <input type="file"
                                        id="profile-image-input" name="image" style="display: none;"> <a href="#"
                                        class="tm-avatar-delete-link"> <i
                                            class="far fa-trash-alt tm-product-delete-icon"></i>
                                    </a>

                                    <button style="align-content:left; width:50%; height:10.5%; font-size:20px;" type="button"
                                        class="btn btn-primary btn-block text-uppercase upload-button">
                                        사진 업로드</button>
                                </div>
                            </div>
                            
                            <div class="form-group mb-3">
                                <label for="description">설문 목적 또는 기타 주의사항</label>
                                <textarea name="content" class="form-control validate"
                                    rows="3">특정 광고에 어울리는 이미지 조사</textarea>
                            </div>
                            <div class="form-group mb-3"></div>
                            <br>

                        </div>
                        <div class="form-group mb-3 col-xs-12 col-sm-6">
                            <label for="expire_date">마감 기한</label> <input id="expire_date" name="end_date" type="text"
                               class="datepicker-here form-control validate" autocomplete="off" />
                        </div>
                        <!--                             data-large-mode="true" -->
                        <div class="col-xl-6 col-lg-6 col-md-12 bigbox">
                            <br> <br> <br>
                            <div class="warning">
                                * 다음항목에 해당되는 설문항목이 포함되어있을 시 경고조치없이 삭제될수있습니다.<br /> 1.폭력적이거나,
                                선정적인 문항.<br /> 2.타인의 권리를 침해하거나, 명예를 훼손하는 문항<br /> 3.개인정보를
                                직접적으로 묻는 문항<br /> <br /> * 같은 설문지를 24시간내에 중복해서 올릴 시, 경고조치와 함께
                                삭제됩니다. <br /> <br /> <br />
                            </div>
                            <div class="col-xl-6 col-lg-6 col-md-12 bigbox surveybox">
                                <div id="addsurveybox_1" class="form-group mb-3 addsurveybox">

                                    <br>
                                    <h3 class="q_num">질문</h3>

                                    <input id="qno" autocomplete="off" name="title" type="text" class="form-control validate qno"
                                        value=""> <br>
                                    <div class="qbox">
                                        <div class="q">
                                            <span>1</span> <input value="" id="name" name="itemcontent" type="text"
                                                class="form-control littleq" autocomplete="off">
                                        </div>
                                        <div class="q">
                                            <span>2</span> <input value="" id="name" name="itemcontent" type="text"
                                                class="form-control littleq" autocomplete="off">
                                        </div>
                                    </div>

                                    <button type="button" class="addq_btn">
                                        <b> +</b>
                                    </button>

                                </div>
                            </div>
                        </div>

                        <div class="col-12">

                            <br /> <br /> <br />
                            <button  id="submit_btn" type="button" class="btn btn-primary btn-block text-uppercase">설문지등록하기</button>
                        </div>


                    </div>
                </div>
            </div>
        </div>
	</form>
   </div>









































































































