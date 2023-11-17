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
  </p>


<!-- 여기에다가 프로필 -->
<div class="container white-box">
      <div class="row">
        <div class="col-md-8 profile-simple">
          <div class="d-flex">
            <div class="flex-shrink-0">
              <c:url value="/images/1.png" var="imageUrl" />
				<img src="${imageUrl}" width="150" height="145" alt="프로필"/>
            </div>
            <div class="flex-grow-1 ms-3">
              <h3>Hyewon</h3>
              <p>Front-end Designer</p>
              <div>
                <i
                  class="fa-solid fa-location-dot d-inline-block"
                  style="color: #6fbaf8"
                ></i>
                <span style="color: #6fbaf8">서울시 동대문구</span>
              </div>
              <button
                class="btn text-white mt-3"
                style="background-color: #6fbaf8"
              >
                연락하기
              </button>
            </div>
          </div>
        </div>
        <div class="col-md-4 border-left">
          <div class="row profile-detail">
            <div class="col-6"><p>Location</p></div>
            <div class="col-6"><p>서울 근무</p></div>
            <div class="col-6"><p>Age</p></div>
            <div class="col-6"><p>25</p></div>
            <div class="col-6"><p>Experience</p></div>
            <div class="col-6"><p>신입</p></div>
            <div class="col-6"><p>School</p></div>
            <div class="col-6"><p>서일대학교 컴퓨터전자공학과</p></div>
          </div>
        </div>
      </div>
    </div>
</c:if>

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