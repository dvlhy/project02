<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
	<h1>회원가입</h1>
	<form id="signup" name="signup" method="post">
		<div>* 은 필수 입력해야 합니다.</div>
		<div>
			<div><label>*이름</label></div>
			<div><input id="name" maxlength="20"></div>
		</div>
		<div>
			<div><label>*아이디</label></div>
			<div><input id="id" maxlength="30"> * 영문 소문자만 입력 가능합니다.</div>
			<div><button id="idChk">중복확인</button></div>
		</div>
		<div>
			<div><label>*비밀번호</label></div>
			<div><input id="password" onblur="valiPw(this, 10, 30);" minlength="10" maxlength="30"> * 영문 대문자, 영문 소문자, 특수 문자, 숫자 각 1개 이상씩 포함 되어야 합니다.</div>
		</div>
		<div>
			<div><label>*비밀번호 확인</label></div>
			<div><input id="passwordChk"></div>
			<div class="alert-success" id="alert-success">비밀번호가 일치합니다.</div> 
			<div class="alert-re" id="alert-re">비밀번호가 일치하지 않습니다.</div>
		</div>
		<div>
			<div><label>*전화번호</label></div>
			<div><input id="cellNum" maxlength="20"></div>
		</div>
		<div>
			<div><label>*이메일</label></div>
			<div>
				<input id="email1" maxlength="80">@<input id="email2" maxlength="20">
				<select id="emailForm">
					<option value="1">직접입력</option>
					<option value="naver.com">naver.com</option>
					<option value="daum.net">daum.net</option>
					<option value="gmail.com">gmail.com</option>
				</select>
			</div>
		</div>
		<div>
			<div><label>성별</label></div>
			<div>
				<input type="radio" name="gender" value="male"> 남성
				<input type="radio" name="gender" value="female"> 여성
			</div>
		</div>
		<div><p><input type="button" id="submit"></p></div>
		<div><p><input type="submit" id="submit" value="회원가입"></p></div>
	</form>
</body>

<script type="text/javascript">

// validation
	$("#submit").on('click', function(){
	//$(document.forms.signup).on('submit',function(){
		var name = $("#name").val();
		var id = $("#id").val();
		var password = $("#password").val();
		var passwordChk = $("#passwordChk").val();
		var cellNum = $("#cellNum").val();
		var email1 = $("#email1").val();
		var email2 = $("#email2").val();
		var gender = $("#gender").val();
		
		if(name.length == 0){
			alert("이름을 입력하세요.");
			return false;
		}
		if(id.length == 0){
			alert("아이디를 입력하세요.");
			return false;
		}
		if(password.length == 0 || passwordChk.length == 0){
			alert("비밀번호를 입력하세요.");
			return false;
		}
		if(password.length < 10){
			alert("비밀번호를 10자 이상 입력하세요.");
			return false;
		}
		if(password != passwordChk){
			alert("비밀번호를 동일하게 입력하세요.");
			return false;
		}
		if(cellNum.length == 0){
			alert("전화번호를 입력하세요.");
			return false;
		}
		if(email1.length == 0 || email2.length == 0){
			alert("이메일을 입력하세요.");
			return false;
		}
		if(gender == null){
			gender = "";
		}
		
		var params = {
			name : name,
			id : id,
			password : password,
			cellNum : cellNum,
			email : email1+"@"+email2,
			gender : gender
		}
		
		
		$.ajax({
			url: "/member/memberCreatePost",
			type: "POST",
			data: params,
			success: function(res){
				//alert("회원가입이 되었습니다.");
				location.href = "/member/detail?mbrId="+id;
			}, error: function(){
				alert("회원가입 중 오류가 발생했습니다. 관리자에게 문의해주세요.");
				location.href = "/";
			}
			
		});
		
		
	});


//id
	$("#idChk").on('click',function(){
		var id = $("#id").val();
		alert("준비중 입니다.");
		return false;
	/*	$.ajax({
			url: "/member/idChk",
			data: id:id,
			//type: "GET",
			//datatype: 'json',
			success: function(data){
				if(data == "Y"){
					alert("이미 존재하는 아이디 입니다.");
					$("#id").val("");
					return;
				}else{
					alert("사용가능한 아이디 입니다.");
					return;
				}
			},
			error: function(){
				alert("다시 시도해 주세요.");
				return;
			}
		}); */
	});



//pw
	$("#alert-success").hide(); 
	$("#alert-re").hide();

	$("input").keyup(function(){ 
		var password = $("#password").val(); 
		var passwordChk = $("#passwordChk").val(); 
		if(password != "" && passwordChk != ""){
			if(password == passwordChk){ 
				$("#alert-success").show();
				$("#alert-re").hide(); 
				$("#submit").removeAttr("disabled"); 
			}else{ 
				$("#alert-success").hide(); 
				$("#alert-re").show(); 
				$("#submit").attr("disabled", "disabled"); 
			} 
		} 
	});


// email
	$("#email2").attr("disabled",true); //비활성화
	
	$("#emailForm").change(function(){
		$("#emailForm option:selected").each(function () {
			if($(this).val()== '1'){ //직접입력일 경우
				$("#email2").val(''); //값 초기화 
				$("#email2").attr("disabled",false); //활성화
			}else{
				$("#email2").val($(this).text()); //선택값 입력 
				$("#email2").attr("disabled",true); //비활성화
			}
		});	
	});
</script>

</html>