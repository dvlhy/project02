<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<head>
<title>main</title>
</head>
<body>
	<h1>마이페이지</h1>
	<div><input type="button" value="로그아웃" id="logout" />
	<input type="button" value="회원정보상세" id="memberInfo" /></div>
	<input type="hidden" value="${id}" id="id" />
	<div>
		<table border="1">
			<tr>
				<th>주문번호</th>
				<th>제품명</th>
				<th>결제일시</th>
			</tr>
			<tbody id="table">
			<c:forEach var="list" items="${list}">
				<tr>
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
		history.replaceState({}, null, location.pathname);
	});
	
	$("#memberInfo").on('click',function(){
		//$(location).attr("href", "/member/detail?id="+$("#id").val());
		$(location).attr("href", "/member/detail");
	});
	
	$("#logout").on('click', function(){
		$.ajax({
			url: "/member/logout",
			type: "POST",
			data: $("#id").val(),
			success: function(res){
				location.href = "/";
			}, error: function(){
				location.href = "/";
			}
			
		});
	});
</script>

</html>