<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta http-equiv="X-UA-Compatible" content="ie=edge" />
<title>설문조사</title>
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Roboto:400,700" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/fontawesome.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/templatemo-style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/popup.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/datepicker.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/imagepopup.css"/>
<script src="/resources/js/jquery-3.3.1.min.js"></script>
<script src="/resources/js/bootstrap.min.js"></script>
<script src="/resources/js/popup.js"></script>
<script src="/resources/js/datepicker.js"></script>
<script src="/resources/js/pagination.js"></script>
<script src="/resources/js/dateformat.js"></script>
<script src="/resources/js/jquery.tmpl.js"></script>
<script src="/resources/js/replybtn.js"></script>




<script>
    $(document).ready(function () {
      $(".tm-product-name").on("click", function () {
        window.location.href = "edit-product.html";
      });
    })
  </script>
</head>

<body id="reportsPage">

	<!-- header -->
	<tiles:insertAttribute name="header" />

	<!-- content -->
	<tiles:insertAttribute name="content" />

	<!-- footer -->
	<tiles:insertAttribute name="footer" />

</body>

</html>