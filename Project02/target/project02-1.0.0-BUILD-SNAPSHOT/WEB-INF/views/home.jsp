<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>Home</title>
</head>
<body>

<style>
.btn{
    display:block;
    width:80px;
    line-height:30px;
    text-align:center;
    background-color:#ffeecc;
    color:#fffee;
    border: groove;
}
</style>

<h1>로그인을 해주세요!</h1>
<form action="POST" method="POST">
	<P>아이디 <input type="text" id="id" name="id" maxlength="30" /></P>
	<P>비밀번호 <input type="text" id="pw" name="pw" maxlength="60" /></P>
	<input type="submit" value="로그인" class="btn">
</form>
<p><a href="/member/memberCreate" class="btn">회원가입</a></p>
</body>
</html>
