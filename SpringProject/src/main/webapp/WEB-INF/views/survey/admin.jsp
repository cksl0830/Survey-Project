<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="container mt-5 searchBox">
    <!--   <div class="row tm-content-row">
          <div class="col-12 tm-block-col"> -->
    <div class="tm-bg-primary-dark tm-block tm-block-h-auto">
        <h2 class="tm-block-title" style="display: inline;">회원관리</h2>
        <br> <select id="searchoption_m" class="custom-select" name="searchoption_m">
            <option selected="selected" disabled="disabled">검색 및 조회조건</option>
            <!--    <option value="authority">Admin등급</option> -->
            <option value="member_seq">회원번호</option>
            <option value="username">회원아이디</option>
            <option value="name">회원이름</option>
            <option value="email">회원이메일</option>
            <option value="enabled">활동여부</option>

        </select> <br> <br> <input id="searchword_m" name="searchword_m" type="text" class="form-control validate" />
        <br>
        <div style="font-size: 10px; color: white;">
            * 검색창에 아무것도 입력하지 않을 시, 전체회원 출력됩니다.<br> * 카테고리는 반드시 선택해야합니다.<br>
            * 활동중 회원은 1, 활동중지회원은 0을 입력하세요.<br>
        </div>
        <br>
        <button id="btn_searchMember" type="button" class="btn btn-primary btn-block text-uppercase">검색하기</button>
        <br>
    </div>
    <div class="tm-bg-primary-dark tm-block tm-block-h-auto">
        <h2 class="tm-block-title" style="display: inline;">게시물 관리</h2>
        <br /> <select id="searchoption_s" class="custom-select" name="searchoption_s">
            <option selected="selected" disabled="disabled">검색 및 조회조건</option>
            <!-- <option value="1">최다 참여 게시물</option>
                <option value="2">24시간이내 중복게시물</option>
                <option value="3">선정적,폭력적 게시물</option> -->
            <option value="name">작성자</option>
            <option value="title">게시물 이름</option>
            <option value="progressing">진행여부</option>
        </select> <br> <br> <input id="searchword_s" name="searchword_s" type="text" class="form-control validate" />
        <br>
        <div style="font-size: 10px; color: white;">
            * 검색창에 아무것도 입력하지 않을 시, 전체게시물 출력됩니다.<br> * 카테고리는 반드시 선택해야합니다.<br>
            * 진행중인 설문은 1, 마감된 설문은 0을 입력하세요.<br>
        </div>
        <br>
        <button id="btn_searchSurvey" type="button" class="btn btn-primary btn-block text-uppercase">검색하기</button>
        <br>
    </div>
</div>


<form id="f">
    <div id="xxx" class="container mt-5 bigdiv">
        <div  id="memberdiv" class="tm-bg-primary-dark tm-block tm-block-h-auto" style="display:none;">
            <h5 style="color:white;">검색결과</h5>
            <table  id="membertable" class="table table-hover tm-table-small tm-product-table">
                <thead>
                    <tr>
                        <th scope="col">&nbsp;</th>
                        <th scope="col">회원번호</th>
                        <th scope="col">회원아이디</th>
                        <th scope="col">회원이름</th>
                        <th scope="col">회원이메일</th>
                        <th scope="col">생일</th>
                        <th scope="col">활동상태</th>
                    </tr>
                </thead>
                <tbody id="membertbody">
                 
                </tbody>
            </table>
            	<div class="pagination_div">
					<ul class="pagination">
						<!-- <li class="page-link"><a href="#">«</a></li>
						<li class="page-link"><a href="#">»</a></li> -->
					</ul>
				</div>
            <button id="btn_unabledmem" class="btn btn-primary btn-block text-uppercase">선택한 회원 활동금지시키기</button>
        </div>
        <div id="surveydiv" class="tm-bg-primary-dark tm-block tm-block-h-auto" style="display:none;" >
            <table id="surveytable" class="table table-hover tm-table-small tm-product-table">
                <thead style="text-align: center">
                   <tr >
                       
                        <th scope="col">&nbsp;</th>
                        <th scope="col">작성회원번호</th>
                        <th scope="col">게시물번호</th>
                        <th scope="col">제 목</th>
                        <th scope="col">등록일</th>
                        <th scope="col">마감일</th>
                        <th scope="col">진행상태</th>
                </thead>
                <tbody id="surveytbody">
                  
                </tbody>
            
            </table>
                <div class="pagination_div">
					<ul class="pagination">
						<!-- <li class="page-link"><a href="#">«</a></li>
						<li class="page-link"><a href="#">»</a></li> -->
					</ul>
				</div>
            <button id="btn_delsurvey" class="btn btn-primary btn-block text-uppercase">선택 게시물 모두 삭제</button>
        </div>
    </div>
</form>
<script>
    $(document).ready(function () {
		function onClickPagelinkForMember(atag) {
			event.preventDefault();
			$("#membertbody").empty();
	    	$("ul.pagination").empty();
			$.ajax({
	            url: $(atag).attr("href"),
	            dataType: "json",
	            cache: false,
	            success: function (data) {
	            	ret = data.searchList;
	            	console.log(ret);
					for (var i = 0; i < ret.length; i++) {
						var tr = $('<tr></tr>');
						var date = new Date(ret[i].birth).format("yyyy-MM-dd");
						var e;
						if (ret[i].enabled == 0)
							var e = "활동중지";
						else
							var e = "활동중";
						
						tr.append(
							' <th scope="row"><input type="checkbox" name="mem" value=' +
							ret[i].member_seq + '></th>');
						tr.append("<td> " + ret[i].member_seq + "</td>");
						tr.append("<td> " + ret[i].username + "</td>");
						tr.append("<td> " + ret[i].name + "</td>");
						tr.append("<td> " + ret[i].email + "</td>");
						tr.append("<td> " + date + "</td>");
						tr.append("<td> " + e + "</td>");
						$("#membertbody").append(tr);
					} //for end
		        	createPagination(
						data.pageMaker.cri.page, //현재 페이지
						data.pageMaker.totalPage, //토탈페이지
						data.pageMaker.displayPageNum, //페이지당 출력 개수
						"getSearchMember?searchoption_m="+data.pageMaker.cri.type +"&searchword_m="+ data.pageMaker.cri.search); //url
					$(".page-btn").on("click", function() {
						onClickPagelinkForMember(this)
					})
					
	            } //end success
	    	}); //end ajax
		}
		
		function onClickPagelinkForSurvey(atag) {
			event.preventDefault();
			$("#surveytbody").empty();
	    	$("ul.pagination").empty();
	    	$.ajax({
	    		url: $(atag).attr("href"),
	            dataType: "json",
	            cache: false,
	            success: function (data) {
					var ret = data.searchList;
	                for (var i = 0; i < ret.length; i++) {
	                    var p;
	                    if (ret[i].progressing == 0) var p = "마감됨";
	                    else 									var p = "진행중";
	
	                    var link="location.href='/survey/readSurvey?survey_seq=" 
	                    				+ ret[i].survey_seq + '&progressing=' + ret[i].progressing + "'";
	                    
	                    var tr =$('<tr style="cursor:pointer;" ></tr>'); 
	              
	                    tr.append(
	                        ' <th scope="row"><input type="checkbox" name="surseq" value=' +
	                        ret[i].survey_seq + '></th>');
	                    tr.append("<td> " + ret[i].member_seq + "</td>");
	                    tr.append("<td> " + ret[i].survey_seq + "</td>");
	                    tr.append("<td onclick= "+link+ " ' > " + ret[i].title + "</td>");
	
	                    var reg_date = new Date(ret[i].reg_date).format("yyyy-MM-dd");
	                    var end_date = new Date(ret[i].end_date).format("yyyy-MM-dd");
	
	                    tr.append("<td> " + reg_date + "</td>");
	                    tr.append("<td> " + end_date + "</td>");
	                    tr.append("<td>" + p + "</td>");
	                   
	                    $("#surveytbody").append(tr);
	                    
	                } //for end
	                createPagination(
						data.pageMaker.cri.page, //현재 페이지
						data.pageMaker.totalPage, //토탈페이지
						data.pageMaker.displayPageNum, //페이지당 출력 개수
						"getSearchSurvey?searchoption_s="+data.pageMaker.cri.type +"&searchword_s="+ data.pageMaker.cri.search); //url
					$(".page-btn").on("click", function() {
						onClickPagelinkForSurvey(this)
					})
	            } //end success
	        }); //end ajax
		}
	
		$('#btn_searchMember').on("click", function () {
			if ($("#searchoption_m").val()==null) {
				noticePopupInit({message:"회원 검색 카테고리를 선택하세요!"});
			}
			else 
			{
	        	$("#membertbody").empty();
	        	$("ul.pagination").empty();
	            $("#surveydiv").attr("style","display:none;");
	            $("#memberdiv").attr("style","display:show;");
	            
	            $.ajax({
	                url: "getSearchMember",
	                dataType: "json",
	                cache: false,
	                data: {
	                    "searchword_m": $("#searchword_m").val(),
	                    "searchoption_m": $("#searchoption_m").val()
	                },
	                success: function (data) {
	                	ret = data.searchList;
	                	console.log(ret);
						for (var i = 0; i < ret.length; i++) {
							var tr = $('<tr></tr>');
							var date = new Date(ret[i].birth).format("yyyy-MM-dd");
							var e;
							if (ret[i].enabled == 0)
								var e = "활동중지";
							else
								var e = "활동중";
							
							tr.append(
								' <th scope="row"><input type="checkbox" name="mem" value=' +
								ret[i].member_seq + '></th>');
							tr.append("<td> " + ret[i].member_seq + "</td>");
							tr.append("<td> " + ret[i].username + "</td>");
							tr.append("<td> " + ret[i].name + "</td>");
							tr.append("<td> " + ret[i].email + "</td>");
							tr.append("<td> " + date + "</td>");
							tr.append("<td> " + e + "</td>");
							$("#membertbody").append(tr);
						} //for end
			        	createPagination(
							data.pageMaker.cri.page, //현재 페이지
							data.pageMaker.totalPage, //토탈페이지
							data.pageMaker.displayPageNum, //페이지당 출력 개수
							"getSearchMember?searchoption_m="+data.pageMaker.cri.type +"&searchword_m="+ data.pageMaker.cri.search); //url
						$(".page-btn").on("click", function() {
							onClickPagelinkForMember(this)
						})
	                } //end success
            	}); //end ajax
			} //end else
        }); //end event click


        $('#btn_searchSurvey').on("click", function () {
        	if ($("#searchoption_s").val()==null) {
        		noticePopupInit({
      					message:"게시물검색 카테고리를 선택하세요 !!"
      					});
			}
			else 
			{
	            $("#surveytbody").empty();
	            $("ul.pagination").empty();
	            $("#memberdiv").attr("style","display:none;");
	            $("#surveydiv").attr("style","display:show;");
	
	            $.ajax({
	                url: "getSearchSurvey",
	                dataType: "json",
	                cache: false,
	
	                data: {
	                    "searchword_s": $("#searchword_s").val(),
	                    "searchoption_s": $("#searchoption_s").val()
	                },
	                success: function (data) {
						var ret = data.searchList;
	                    for (var i = 0; i < ret.length; i++) {
	                        var p;
	                        if (ret[i].progressing == 0) var p = "마감됨";
	                        else 									var p = "진행중";
	
	                        var link="location.href='/survey/readSurvey?survey_seq=" 
	                        				+ ret[i].survey_seq + '&progressing=' + ret[i].progressing + "'";
	                        
	                        var tr =$('<tr style="cursor:pointer;" ></tr>'); 
	                  
	                        tr.append(
	                            ' <th scope="row"><input type="checkbox" name="surseq" value=' +
	                            ret[i].survey_seq + '></th>');
	                        tr.append("<td> " + ret[i].member_seq + "</td>");
	                        tr.append("<td> " + ret[i].survey_seq + "</td>");
	                        tr.append("<td onclick= "+link+ " ' > " + ret[i].title + "</td>");
	
	                        var reg_date = new Date(ret[i].reg_date).format("yyyy-MM-dd");
	                        var end_date = new Date(ret[i].end_date).format("yyyy-MM-dd");
	
	                        tr.append("<td> " + reg_date + "</td>");
	                        tr.append("<td> " + end_date + "</td>");
	                        tr.append("<td>" + p + "</td>");
	                       
	                        $("#surveytbody").append(tr);
	                        
	                    } //for end
	                    createPagination(
							data.pageMaker.cri.page, //현재 페이지
							data.pageMaker.totalPage, //토탈페이지
							data.pageMaker.displayPageNum, //페이지당 출력 개수
							"getSearchSurvey?searchoption_s="+data.pageMaker.cri.type +"&searchword_s="+ data.pageMaker.cri.search); //url
						$(".page-btn").on("click", function() {
							onClickPagelinkForSurvey(this)
						})
	                } //end success
	            }); //end ajax
			} //end else
        }); //end event click
		
        //페이징 처리
        $("#btn_searchMember #btn_searchSurvey").on("click", function(){
        	
        });

        $(document).on('click', '#btn_unabledmem', function () {
        	event.preventDefault();
            var str = $("form").serialize();
             
            console.log(str);


            $.ajax({
                url: "modifyMemberUnabled",
                dataType: "json",
                cache: false,
                data: str,
                success: function (ret) {
                    console.log(ret.message);
                   	confirm("해당회원들을 정말 활동중지시키겠습니까?")
                    $("input[name=mem]:checked").each(function (i) {
                        $(this).parent().parent().remove();
                    });
                }
            });
        });

        $(document).on('click', '#btn_delsurvey', function (event) {
        	event.preventDefault();
            var str= $("form").serialize();
           	 
            console.log(str);


            $.ajax({
                url: "removeSurveyUnabled",
                dataType: "json",
                cache: false,
                data: str,
                success: function (ret) {
                    console.log(ret.message);
			        confirm("해당게시물들을 정말  삭제시키겠습니까?")
			        $("input[name=surseq]:checked").each(function (i) {
			            
			        	$(this).parent().parent().remove();
			            
			        });
                }
            });
        });
    });
</script>
