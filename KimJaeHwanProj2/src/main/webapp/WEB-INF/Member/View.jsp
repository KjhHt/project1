<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/template/HeadNav.jsp"/>

<div class="jumbotron">
	<!-- 나중에 -->
	<form action="<c:url value="/Board/Insert.kjh"/>" method="post">
	</form>
	  <fieldset>
	    <legend>상세보기 값들어오나 테스트</legend>
	    
	    <div class="form-group">
	      <label for="exampleInputEmail1">제목</label>
	      <input type="text" class="form-control" id="title" value="${record.title }" placeholder="제목을 입력하세요">
	    </div>
	    <div class="form-group">
	      <label for="exampleTextarea">내용</label>
	      <textarea class="form-control" id="content" rows="3">${record.content }</textarea>
	    </div>
	    <button type="submit" class="btn btn-primary">없앨거임</button>
	  </fieldset>

	
	
</div>