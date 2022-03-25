<%@ page pageEncoding="UTF-8" contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
	<head>
		<title>회원 상세</title>
	</head>
	<body>
		<input type="hidden" value="${data.ID}" id="id" />
		<h1>회원 상세</h1>
		<p>이름 : ${data.NAME}</p>
		<p>아이디 : ${data.ID}</p>
		<p>비밀번호 : ${data.PASSWORD}</p>
		<p>전화번호 : ${data.CELLNUM}</p>
		<p>이메일 : ${data.EMAIL}</p>
		<p>성별 : ${data.GENDER}</p>
		<p>권한등급 : ${data.AUTH}</p>
	
		<div>	
		<%-- <p><a id="modify" href="/member/update?id="${data.ID}">수정</a></p> --%>
		<input type="button" value="수정" id="modify">
	  	<!--<form action="/member/delete" method="POST">
			<input type="hidden" name="id" value="${data.ID}" />
			<input type="submit" value="삭제" />
		</form>-->
		<input type="button" value="목록" id="main">
		</div>
	</body>
	
<script type="text/javascript">
$("#modify").on('click', function(){
	alert("준비중입니다.");
});

$("#main").on('click',function(){
	$(location).attr("href", "/member/main");
});
</script>

</html>