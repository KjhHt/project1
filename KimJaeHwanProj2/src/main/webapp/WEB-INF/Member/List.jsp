<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/template/HeadNav.jsp"/>
<div class="jumbotron">
<a class="btn btn-primary btn-lg" href="<c:url value="/Board/Insert.kjh"/>" role="button">글등록</a>
  <table class="table table-hover">
  <thead>
    <tr style="text-align:center">
      <th scope="col" colspan="2" >제목</th>
      <th scope="col">작성자</th>
      <th scope="col">작성일</th>
      <th scope="col">조회</th>
      <th scope="col">좋아요(미구현)</th>
    </tr>
  </thead>
  <tbody>
  	<c:forEach var="list" items="${list}">
	    <tr>
	      <th scope="row" style="text-align:center">${list.no}</th>
	      <td>${list.title}</td>
	      <td style="text-align:center">${list.username}</td>
	      <td style="text-align:center">${list.postdate}</td>
	      <td style="text-align:center">${list.visitcount}</td>
	      <td style="text-align:center">0</td>
	    </tr>
	</c:forEach>
  </tbody>
</table>
</div>