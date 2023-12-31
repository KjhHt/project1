<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/template/HeadNav.jsp" />


<div class="form-group email-form">
	 <label for="email">이메일</label>
	 <div class="input-group">
	<input type="text" class="form-control" name="userEmail1" id="userEmail1" placeholder="이메일" >
	<select class="form-control" name="userEmail2" id="userEmail2" >
	<option>@naver.com</option>
	<option>@daum.net</option>
	<option>@gmail.com</option>
	<option>@hanmail.com</option>
	 <option>@yahoo.co.kr</option>
	</select>
</div>   
<div class="input-group-addon">
	<button type="button" class="btn btn-primary" id="mail-Check-Btn">본인인증</button>
</div>
	<div class="mail-check-box">
<input class="form-control mail-check-input" placeholder="인증번호 6자리를 입력해주세요!" disabled="disabled" maxlength="6">
</div>
	<span id="mail-check-warn"></span>
</div>






						
						
<c:if test="${empty username}">	
<div class="jumbotron">				
<div class="container py-5" id="hometop">
  <div class="row pt-5 mt-5 align-items-center justify-content-center justify-content-lg-between text-center text-lg-left ">
    <div class="col-md-9 col-lg-6 col-xl-5 mb-4 mb-lg-0 pr-lg-5 pr-xl-0">
      <div>
        <h1 class="display-4">게시판 구현</h1>
        <p class="lead">회원이 아니신가요?? &rarr;
        	<a class="text-danger" href="<c:url value="/JoinMember.kjh"/>">회원가입</a>
        </p>
        <div class="mt-4 mt-md-5">
          <form id="frm" action="<c:url value="/Login.kjh"/>" method="post">
          	<c:if test="${not empty ERROR }">
            	<div class="text-danger mb-2" style="text-align:center; font-size:20px">아이디와 비밀번호가 일치하지 않아요!</div>
            </c:if>
            <input class="form-control h-100" type="text" id="username" name="username" placeholder="아이디를 입력하세요">
            <input class="form-control h-100 my-3" type="password" id="password" name="password" placeholder="비밀번호를 입력하세요">
            <div class="custom-control custom-checkbox mt-3">
				<input type="checkbox" class="custom-control-input" name="idSave" value="N" id="idSave" />
				<label class="custom-control-label" for="idSave">아이디 저장</label>
            </div>
            <button id="loginBtn" class="btn btn-primary flex-shrink-0" type="button" onclick="return chk_login()">로그인</button>
          </form>
        </div>
      </div>
    </div>
    <c:url value="/images/1.png" var="imageUrl" />
    <div class="col-md-9 col-lg-6"> <img src="${imageUrl}" alt="Image" class="img-fluid mt-5 mt-md-0"> </div>
  </div>
</div>
</div>
</c:if>
<c:if test="${not empty username}">
<div class="jumbotron">
<div class="container py-5" id="hometop">
  <div class="row pt-5 mt-5 align-items-center justify-content-center justify-content-lg-between text-center text-lg-left flex-lg-row-reverse">
    <div class="col-md-9 col-lg-6 col-xl-5 mb-4 mb-lg-0 pr-lg-5 pr-xl-0">
      <div>
        <h1 class="display-4">로그인 완료~~</h1>
      </div>
    </div>
    <c:url value="/images/1.png" var="imageUrl" />
    <div class="col-md-9 col-lg-6"> <img src="${imageUrl}" alt="Image" class="img-fluid mt-5 mt-md-0"> </div>
  </div>
</div>
</div>
</c:if>	
















<script>






	document.addEventListener("keydown", function(event) {
		if (event.keyCode === 13) {
			console.log('엔터누름')
			document.getElementById("loginBtn").click();
		}
	});
	
	function chk_login(){
		if(document.getElementById("username").value===''){
			alert('아이디를 입력해주세요');
			document.getElementById("username").focus();
			return false;
		}
		if(document.getElementById("password").value===''){
			alert('비밀번호를 입력해주세요');
			document.getElementById("password").focus();
			return false;
		}
		var idSave = document.getElementById('idSave');
		var usernameInput = document.getElementById('username');
		if (idSave) {
	        if (idSave.checked)
	            localStorage.setItem('idSave', document.getElementById("username").value);
	        else
	            localStorage.removeItem('idSave');
		}
		
		document.getElementById('frm').submit();
	}
	
	var idSave = document.getElementById('idSave');
	var usernameInput = document.getElementById('username');	
	if (idSave) {
	    if (localStorage.getItem('idSave')) {
	    	usernameInput.value = localStorage.getItem('idSave');
	        idSave.checked = true;
	    }
	    idSave.onchange = function () {
	        if (idSave.checked)
	            localStorage.setItem('idSave', document.getElementById("username").value);
	        else
	            localStorage.removeItem('idSave');
	    };
	}
	
</script>