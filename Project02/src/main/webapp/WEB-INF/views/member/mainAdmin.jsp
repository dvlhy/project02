<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<head>
<title>admin</title>
</head>
<body>
<h1>관리자 페이지</h1>
<div>
<form name="search" method="post">
	<input type="text" placeholder="이름" id="nameSearch" />
	<input type="text" placeholder="이메일" id="emailSearch" />
	<input type="button" value="검색" id="search" />
</form>
</div>
<div>
	<table border="1">
		<tr>
			<th>아이디</th>
			<th>이름</th>
			<th>이메일</th>
			<th>주문번호</th>
			<th>제품명</th>
			<th>결제일시</th>
		</tr>
		<tbody id="table">
		<c:forEach var="list" items="${list}">
			<tr>
				<td><c:out value="${list.ID}" /></td>
				<td><c:out value="${list.NAME}" /></td>
				<td><c:out value="${list.EMAIL}" /></td>
				<td><c:out value="${list.ORDERNO}" /></td>
				<td><c:out value="${list.PRODUCTNAME}" /></td>
				<td><c:out value="${list.ORDERDATE}" /></td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</div>
</body>
<script type="text/javascript">
$(document).ready(function(){
	
});

$("#search").on('click', function(){
	 $.ajax({
		url: "/member/searchList",
		type: "POST",
		async: false,
		data: {nameSearch: $("#nameSearch").val(), emailSearch: $("#emailSearch").val()},
		success: function(res){
			//location.href = "/member/mainAdmin";
			alert(res.list);
			console.log(res.list[0]);
		}, error: function(){
			location.href = "/";
		}
		
	}); 
});
</script>
</html>