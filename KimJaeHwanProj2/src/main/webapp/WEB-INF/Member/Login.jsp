<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/template/HeadNav.jsp"/>

<div class="jumbotron">
  <h1 class="display-4">로그인</h1>
  <p class="lead" style="text-align:center">${ERROR}</p>
  <hr class="my-4">
  	<c:if test="${empty username}">
  	<form id="frm" action="<c:url value="/Login.kjh"/>" method="post">
		<div class="form-group">
		  <label class="col-form-label" for="inputDefault">아이디</label>
		  <input type="text" class="form-control" placeholder="Default input" id="username" name="username"/>
		</div>
		<div class="form-group">
		  <label class="col-form-label" for="inputDefault">비밀번호</label>
		  <input type="password" class="form-control" placeholder="Default input" id="password" name="password"/>
		</div>
	</form>
  <p class="lead">
    <a class="btn btn-primary btn-lg" href="#" role="button" onclick="return chk_login()">로그인</a>
    <a class="btn btn-success btn-lg" href="<c:url value="/JoinMember.kjh"/>" role="button">회원가입</a>
    
    </c:if>
    <c:if test="${not empty username}">
    <a class="btn btn-success btn-lg" href="<c:url value="/Board/EditMember.kjh"/>" role="button">회원정보수정</a>
    <a class="btn btn-danger btn-lg" href="<c:url value="/Logout.kjh"/>" role="button">로그아웃</a>
    <a class="btn btn-danger btn-lg" href="<c:url value="/Board/List.kjh"/>" role="button">리스트</a>
  	</c:if>
  </p>
</div>


<script>

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
		document.getElementById('frm').submit();
	}
</script>