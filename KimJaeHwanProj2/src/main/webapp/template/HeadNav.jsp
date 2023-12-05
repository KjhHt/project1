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
   <link href="<c:url value='/template/css/_bootswatch.scss'/>" rel="stylesheet">
   <link href="<c:url value='/template/css/_variables.scss'/>" rel="stylesheet">
   <link href="<c:url value='/template/css/bootstrap.css'/>" rel="stylesheet">
   <link href="<c:url value='/template/css/bootstrap.min.css'/>" rel="stylesheet">
   <%-- <link href="<c:url value='/template/css/style.css'/>" rel="stylesheet"> --%>

</head>
<!-- Topbar -->
<nav class="navbar navbar-expand navbar-light bg-white topbar static-top shadow" style="border:0; height:60px">
    <!-- Topbar Navbar -->
    <ul class="navbar-nav ml-auto">
	<c:if test="${username eq null}">
        <li class="nav-item no-arrow">
            <a class="nav-link" href="<c:url value="/Login.kjh"/>" id="" role="button" style="font-weight:bold;">
				|  로그인  |
            </a>
		</li>
        <li class="nav-item no-arrow">
            <a class="nav-link" href="<c:url value="/JoinMember.kjh"/>" id="" role="button" style="font-weight:bold;">
				|  회원가입  |
            </a>
		</li>
	</c:if>
	<c:if test="${username ne null}">
        <li class="nav-item no-arrow">
            <a class="nav-link" href="<c:url value="/Board/List.kjh"/>" id="" role="button" style="font-weight:bold;">
				|  리스트  |
            </a>
		</li>
        <li class="nav-item no-arrow">
            <a class="nav-link" href="<c:url value="/Board/MyPage.kjh"/>" id="" role="button" style="font-weight:bold;">
				|  마이페이지  |
            </a>
		</li>
        <li class="nav-item no-arrow">
            <a class="nav-link" href="<c:url value="/Logout.kjh"/>" id="" role="button" style="font-weight:bold;">
				|  로그아웃  |
            </a>
		</li>
		<c:url value="/images/${profile}.png" var="imageUrl" />
        <li class="nav-item">
            <a class="nav-link" href="#" id="userDropdown" role="button">
                <span class="mr-2 d-none d-lg-inline" style="color:black; font-weight:bold; font-size:15px;">홍길동님</span>
                <img class="img-profile rounded-circle" style="width:19px;"
                    src="${imageUrl}">
            </a>
        </li>
	</c:if>
    </ul>
</nav>
