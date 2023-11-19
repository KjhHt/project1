<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
   <meta charset="UTF-8">
   <meta http-equiv="X-UA-Compatible" content="IE=edge">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
  
  
   <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
   <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.min.js"></script>
   <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
   <script src="https://kit.fontawesome.com/0b4621b427.js" crossorigin="anonymous"></script>
   <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
   <link href="/KimJaeHwanProj2/template/css/bootswatch.css" rel="stylesheet">
   <link href="/KimJaeHwanProj2/template/css/_variables.scss" rel="stylesheet">
   <link href="/KimJaeHwanProj2/template/css/bootstrap.css" rel="stylesheet">
   <link href="/KimJaeHwanProj2/template/css/bootstrap.min.css" rel="stylesheet">
</head>



<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
  <a class="navbar-brand" href="<c:url value="/"/>">게시판</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarColor01" aria-controls="navbarColor01" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarColor01">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item">
        <a class="nav-link" href="<c:url value="/Board/List.kjh"/>">리스트</a>
        <a class="nav-link" href="<c:url value="/Board/MyPage.kjh"/>">마이페이지</a>
      </li>
    </ul>
    <c:if test="${username ne null}">
	    <span style="font-size:18px" class="text-white font-weight-bold display-5">${username}님 반가워용^^! &nbsp;&nbsp;&nbsp;</span> 
	    <a class="btn btn-danger btn-lg" href="<c:url value="/Logout.kjh"/>" role="button">로그아웃</a>
	</c:if>
  </div>
</nav>